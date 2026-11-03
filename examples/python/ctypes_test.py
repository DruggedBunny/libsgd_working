"""LibSGD from Python using only the standard library (ctypes) - no SWIG module needed.

Uses ../../lib/sgd_dynamic.dll (or one beside this script), then:  python ctypes_test.py [frames]
sgd:// assets are found in a 'libsgd_assets' folder beside the libsgd folder (see README).
"""
import ctypes as C
import os
import sys

here = os.path.dirname(os.path.abspath(__file__))
for dll_path in (os.path.join(here, "..", "..", "lib", "sgd_dynamic.dll"), os.path.join(here, "sgd_dynamic.dll")):
    if os.path.exists(dll_path):
        break
sgd = C.CDLL(os.path.abspath(dll_path))

F, I, S, H = C.c_float, C.c_int, C.c_char_p, C.c_int  # handles are plain ints
# SGD_Real (entity positions/rotations etc) is a double in 64 bit builds (float in 32 bit builds).
R = C.c_double if C.sizeof(C.c_void_p) == 8 else C.c_float


def api(name, restype, *argtypes):
    fn = getattr(sgd, "sgd_" + name)
    fn.restype, fn.argtypes = restype, list(argtypes)
    return fn


Init = api("Init", None)
Terminate = api("Terminate", None)
CreateWindow = api("CreateWindow", None, I, I, S, I)
PollEvents = api("PollEvents", I)
IsKeyHit = api("IsKeyHit", I, I)
RenderScene = api("RenderScene", None)
Present = api("Present", None)
GetRPS = api("GetRPS", F)
CreatePerspectiveCamera = api("CreatePerspectiveCamera", H)
MoveEntity = api("MoveEntity", None, H, R, R, R)
TurnEntity = api("TurnEntity", None, H, R, R, R)
LoadSkybox = api("LoadSkybox", H, S, F)
LoadPBRMaterial = api("LoadPBRMaterial", H, S)
CreateBoxMesh = api("CreateBoxMesh", H, F, F, F, F, F, F, H)
CreateModel = api("CreateModel", H, H)
CreateDirectionalLight = api("CreateDirectionalLight", H)
LoadFont = api("LoadFont", H, S, F)
Set2DFont = api("Set2DFont", None, H)
Set2DFillColor = api("Set2DFillColor", None, F, F, F, F)
Draw2DText = api("Draw2DText", None, S, F, F)

KEY_ESCAPE = 256
EVENT_MASK_CLOSE_CLICKED = 1

max_frames = int(sys.argv[1]) if len(sys.argv) > 1 else 0

Init()
CreateWindow(1024, 576, b"LibSGD Python (ctypes) test", 0)

camera = CreatePerspectiveCamera()
MoveEntity(camera, 0, 2, -6)
TurnEntity(camera, 15, 0, 0)

if not LoadSkybox(b"sgd://envmaps/sunnysky-cube.png", 0.0):
    print("FAILED to load skybox")

brick = LoadPBRMaterial(b"sgd://materials/Bricks076C_1K-JPG")
box = CreateModel(CreateBoxMesh(-1, -1, -1, 1, 1, 1, brick))
MoveEntity(box, 0, 1, 0)

ground = LoadPBRMaterial(b"sgd://materials/Ground037_1K-JPG")
CreateModel(CreateBoxMesh(-20, -1, -20, 20, 0, 20, ground))

light = CreateDirectionalLight()
TurnEntity(light, -50, 30, 0)

font = LoadFont(b"sgd://fonts/FiraCode-Medium.ttf", 24)
if font:
    Set2DFont(font)

frame = 0
while True:
    if PollEvents() & EVENT_MASK_CLOSE_CLICKED:
        break
    if IsKeyHit(KEY_ESCAPE):
        break
    TurnEntity(box, 0, 0.5, 0)
    RenderScene()
    Set2DFillColor(1, 1, 1, 1)
    Draw2DText(b"LibSGD from Python - ESC to quit", 10, 10)
    Present()
    frame += 1
    if max_frames and frame >= max_frames:
        break

print("frames=%d rps=%.1f" % (frame, GetRPS()))
Terminate()
