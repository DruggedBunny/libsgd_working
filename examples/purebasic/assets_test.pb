; LibSGD from PureBasic (x64). Place sgd_dynamic.dll and sgd_dynamic.lib beside this file.
; Compile with the 64-bit compiler:  pbcompiler assets_test.pb /CONSOLE /EXE assets_test.exe
; sgd:// assets are found in a 'libsgd_assets' folder beside the libsgd folder (see README).
; Run:  assets_test [frames]   (frames > 0 quits automatically after that many frames)

EnableExplicit

ImportC "sgd_dynamic.lib"
  sgd_Init()
  sgd_Terminate()
  sgd_CreateWindow(width.l, height.l, title.p-utf8, flags.l)
  sgd_PollEvents.l()
  sgd_IsKeyHit.l(key.l)
  sgd_RenderScene()
  sgd_Present()
  sgd_GetRPS.f()
  sgd_CreatePerspectiveCamera.l()
  sgd_MoveEntity(entity.l, x.d, y.d, z.d) ; SGD_Real is a double in 64 bit builds
  sgd_TurnEntity(entity.l, x.d, y.d, z.d)
  sgd_LoadSkybox.l(path.p-utf8, roughness.f)
  sgd_LoadPBRMaterial.l(path.p-utf8)
  sgd_CreateBoxMesh.l(minX.f, minY.f, minZ.f, maxX.f, maxY.f, maxZ.f, material.l)
  sgd_CreateModel.l(mesh.l)
  sgd_CreateDirectionalLight.l()
  sgd_LoadFont.l(path.p-utf8, height.f)
  sgd_Set2DFont(font.l)
  sgd_Set2DFillColor(r.f, g.f, b.f, a.f)
  sgd_Draw2DText(text.p-utf8, x.f, y.f)
EndImport

#SGD_KEY_ESCAPE = 256
#SGD_EVENT_MASK_CLOSE_CLICKED = 1

Define maxFrames.l = Val(ProgramParameter())
Define frame.l

OpenConsole()

sgd_Init()
sgd_CreateWindow(1024, 576, "LibSGD PureBasic assets test", 0)

Define camera.l = sgd_CreatePerspectiveCamera()
sgd_MoveEntity(camera, 0, 2, -6)
sgd_TurnEntity(camera, 15, 0, 0)

If sgd_LoadSkybox("sgd://envmaps/nightsky-cube.png", 0.0) = 0
  PrintN("FAILED to load skybox")
EndIf

Define brick.l = sgd_LoadPBRMaterial("sgd://materials/Bricks076C_1K-JPG")
Define box.l = sgd_CreateModel(sgd_CreateBoxMesh(-1, -1, -1, 1, 1, 1, brick))
sgd_MoveEntity(box, 0, 1, 0)

Define ground.l = sgd_LoadPBRMaterial("sgd://materials/Ground037_1K-JPG")
sgd_CreateModel(sgd_CreateBoxMesh(-20, -1, -20, 20, 0, 20, ground))

Define light.l = sgd_CreateDirectionalLight()
sgd_TurnEntity(light, -50, 30, 0)

Define font.l = sgd_LoadFont("sgd://fonts/FiraCode-Medium.ttf", 24)
If font : sgd_Set2DFont(font) : EndIf

Repeat
  If sgd_PollEvents() & #SGD_EVENT_MASK_CLOSE_CLICKED : Break : EndIf
  If sgd_IsKeyHit(#SGD_KEY_ESCAPE) : Break : EndIf

  sgd_TurnEntity(box, 0, 0.5, 0)

  sgd_RenderScene()
  sgd_Set2DFillColor(1, 1, 1, 1)
  sgd_Draw2DText("LibSGD from PureBasic - ESC to quit", 10, 10)
  sgd_Present()

  frame + 1
  If maxFrames And frame >= maxFrames : Break : EndIf
ForEver

PrintN("frames=" + Str(frame) + " rps=" + StrF(sgd_GetRPS(), 1))
sgd_Terminate()

