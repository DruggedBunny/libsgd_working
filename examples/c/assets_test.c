// LibSGD C example: loads assets via sgd:// (from the libsgd_assets folder) and renders a small scene.
//
// Build (MinGW, from this folder, with sgd_dynamic.dll/.lib copied alongside):
//   build.bat   (or: gcc -I../../include -DSGD_DYNAMIC=1 -o assets_test assets_test.c -L../../lib -lsgd_dynamic)
//
// Run:  assets_test [frames]     (frames > 0 quits automatically after that many frames)

#include <sgd/sgd.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {

	int maxFrames = argc > 1 ? atoi(argv[1]) : 0;

	sgd_Init();
	sgd_CreateWindow(1024, 576, "LibSGD C assets test", 0);

	SGD_Camera camera = sgd_CreatePerspectiveCamera();
	sgd_MoveEntity(camera, 0, 2, -6);
	sgd_TurnEntity(camera, 15, 0, 0);

	SGD_Skybox skybox = sgd_LoadSkybox("sgd://envmaps/stormy-cube.jpg", 0.0f);
	if (!skybox) printf("FAILED to load skybox\n");

	SGD_Material mat = sgd_LoadPBRMaterial("sgd://materials/Bricks076C_1K-JPG");
	SGD_Mesh mesh = sgd_CreateBoxMesh(-1, -1, -1, 1, 1, 1, mat);
	SGD_Model box = sgd_CreateModel(mesh);
	sgd_MoveEntity(box, 0, 1, 0);

	SGD_Material ground = sgd_LoadPBRMaterial("sgd://materials/Ground037_1K-JPG");
	SGD_Mesh gmesh = sgd_CreateBoxMesh(-20, -1, -20, 20, 0, 20, ground);
	sgd_CreateModel(gmesh);

	SGD_Light light = sgd_CreateDirectionalLight();
	sgd_TurnEntity(light, -50, 30, 0);

	SGD_Font font = sgd_LoadFont("sgd://fonts/FiraCode-Medium.ttf", 24);
	if (font) sgd_Set2DFont(font);

	int frame = 0;
	for (;;) {
		if (sgd_PollEvents() & SGD_EVENT_MASK_CLOSE_CLICKED) break;
		if (sgd_IsKeyHit(SGD_KEY_ESCAPE)) break;

		sgd_TurnEntity(box, 0, 0.5f, 0);

		sgd_RenderScene();
		sgd_Set2DFillColor(1, 1, 1, 1);
		sgd_Draw2DText("LibSGD assets test - ESC to quit", 10, 10);
		sgd_Present();

		if (maxFrames && ++frame >= maxFrames) break;
	}
	printf("frames=%d rps=%.1f\n", frame, sgd_GetRPS());
	sgd_Terminate();
	return 0;
}
