
'	KEYS:

' 	WASD				- forward/back/strafe
' 	CURSORS				- turn/look around
'	LEFT-SHIFT			- speed boost

' Set CAMERA_PITCH_INVERT to True to invert pitch control

Include "../sgd.bmx"

Const FULL_SCREEN:Int = False
'Const FULL_SCREEN:Int = True ' Keyboard control too twitchy. Vsync??

Const CAMERA_PITCH_INVERT:Int = False ' True to flip look-up/down on Xbox pad

Const GRAVITY:Float = -0.01

' Normally place sgd_dynamic.dll in same folder and just
' call SGD.LoadSGD to import LibSGD. Distribution demo requires
' custom path, hence:

SGD.LoadSGD "../../../lib/sgd_dynamic.dll"

SGD.Init ' Normal SGD setup call

Const COLLIDE_CAMERA:Int = 1
Const COLLIDE_LAND:Int = 2

' --------
' WINDOW:
' --------

Local flags:Int = SGD.WINDOW_FLAGS_RESIZABLE

If FULL_SCREEN
	flags = SGD.WINDOW_FLAGS_FULLSCREEN
EndIf

SGD.CreateWindow (1280, 720, "Stuporman - WASD/Shift plus CURSORS, SPACE to toggle flying/walking", flags)

' -----------------------------------------------------------------------------
' Envmaps -- uncomment one only:
' -----------------------------------------------------------------------------

'Local sky_texture_file:String = "nightsky-cube.png"
'Local sky_texture_file:String = "stormy-cube.jpg"
Local sky_texture_file:String = "sunnysky-cube.png"

' -----------------------------------------------------------------------------
' Selection from above...
' -----------------------------------------------------------------------------

Local sky_map_path:String			= "sgd://envmaps/"		+ sky_texture_file

' -------
' SCENE:
' -------

SGD.SetAmbientLightColor 0.25, 0.5, 0.375, 1.0

' --------
' SKYBOX:
' --------

Local sky_texture:Int = SGD.LoadCubeTexture (sky_map_path, SGD.TEXTURE_FORMAT_ANY, SGD.TEXTURE_FLAGS_DEFAULT)

SGD.SetEnvTexture sky_texture

Local skybox:Int = SGD.CreateSkybox (sky_texture)
SGD.SetSkyboxRoughness skybox, 0.3

' --------
' ISLAND:
' --------

Local land_mesh:Int = SGD.LoadMesh ("neodemo/media/model.gltf")
Local land:Int = SGD.CreateModel (land_mesh)

Local ground_size:Float = 512
SGD.FitMesh land_mesh, -ground_size, -ground_size * 0.5, -ground_size, ground_size, 0, ground_size, False
SGD.SetMeshShadowsEnabled land_mesh, True

Local land_collider:Int = SGD.CreateMeshCollider (land, COLLIDE_LAND, land_mesh)

' -------
' LIGHT:
' -------

Local light:Int = CreateDebugDirectionalLight (25)

' Light details:

SGD.SetLightRange light, 2000.0
SGD.SetLightShadowsEnabled (light, True) ' CASTING SHADOW
SGD.SetLightColor light, 0.5, 0.5, 0.5, 1.0

' Positioning:

SGD.MoveEntity light, -500, 250, 500
SGD.AimEntityAtEntity light, land, 0.0

' --------
' CAMERA:
' --------

Local camera:Int = SGD.CreatePerspectiveCamera ()

SGD.SetCameraNear camera, 0.05
SGD.SetCameraFar camera, 1000.0
SGD.MoveEntity camera, 0, 50, 0	' Positioning

Local camera_collider:Int = SGD.CreateSphereCollider (camera, COLLIDE_CAMERA, 1.65)

' -----------------------
' COLLIDER INTERACTIONS:
' -----------------------

SGD.EnableCollisions COLLIDE_CAMERA, COLLIDE_LAND, SGD.COLLISION_RESPONSE_SLIDE

' -----
' FOG:
' -----

Local fog:Int = SGD.CreateFogEffect ()

SGD.SetFogEffectPower (fog, 3)

' Window events variables...

Local events:Int
Local quit:Int = False

' Camera movement variables...

Local pitch:Double = 0.0
Local yaw:Double = 0.0
Local strafe:Double = 0.0
Local z:Double = 0.0

Local camera_ys:Double = 0.0

Local walking:Int = 1 ' 1 = walking, 0 = flying

Repeat

	' Get window events...
	
	events = SGD.PollEvents ()
	
	' Check for ESC key or window close gadget-hit...
	
	If SGD.IsKeyHit (SGD.KEY_ESCAPE) Or events & SGD.EVENT_MASK_CLOSE_CLICKED
		quit = True
	EndIf
	
	' No gamepad input, use keys (er, which turned out better):
	
	' LEFT/RIGHT cursors: camera strafe...
	
	If SGD.IsKeyDown (SGD.KEY_LEFT)
		yaw = yaw + 0.1
		If yaw > 1.5 Then yaw = 1.5
	Else
		If SGD.IsKeyDown (SGD.KEY_RIGHT)
			yaw = yaw - 0.1
			If yaw < -1.5 Then yaw = -1.5
		EndIf
	EndIf

	' Pitch inversion option...
	
	Local pitcher:Float = 1.0
	
	If CAMERA_PITCH_INVERT Then pitcher = -1.0
	
	' UP/DOWN cursors: camera tilt...
	
	If SGD.IsKeyDown (SGD.KEY_UP)
		pitch = pitch - 0.1 * pitcher
		If pitch < -1.5 Then pitch = -1.5
	Else
		If SGD.IsKeyDown (SGD.KEY_DOWN)
			pitch = pitch + 0.1 * pitcher
			If pitch > 1.5 Then pitch = 1.5
		EndIf
	EndIf

	' Camera boost with LEFT SHIFT...
	
	Local shifted:Float = 1.0
	
	If Not walking And SGD.IsKeyDown (SGD.KEY_LEFT_SHIFT)
		shifted = 2.0
	EndIf
	
	' A/D keys: strafe left/right...

	If SGD.IsKeyDown (SGD.KEY_A)
		strafe = strafe - 0.025 * shifted
		If strafe < -0.5 * shifted Then strafe = -0.5 * shifted
	Else
		If SGD.IsKeyDown (SGD.KEY_D)
			strafe = strafe + 0.025 * shifted
			If strafe > 0.5 * shifted Then strafe = 0.5 * shifted
		EndIf
	EndIf

	' W/S keys: forward/back...

	If SGD.IsKeyDown (SGD.KEY_W)
		z = z + 0.05 * shifted
		If z > 1.0 * shifted Then z = 1.0 * shifted
	Else
		If SGD.IsKeyDown (SGD.KEY_S)
			z = z - 0.05 * shifted
			If z < -1.0 * shifted Then z = -1.0 * shifted
		EndIf
	EndIf

	If SGD.IsKeyHit (SGD.KEY_SPACE)
		walking = 1 - walking
		If Not walking Then camera_ys = 0.0
	EndIf
	
	' Diminish all movement towards 0...
	
	pitch	= Util.Diminish (pitch, 0.03)
	yaw		= Util.Diminish (yaw, 0.03)
	strafe	= Util.Diminish (strafe, 0.015)
	z		= Util.Diminish (z, 0.015)

	' Update camera...
	
	SGD.TurnEntity camera, pitch, 0, 0
	SGD.RotateEntity camera, 0, yaw, 0
	
	If walking Then camera_ys = camera_ys + GRAVITY
	
	SGD.MoveEntity camera, strafe, 0.0, z
	SGD.TranslateEntity camera, 0.0, camera_ys, 0.0
	
	' Colliders...
	
	SGD.UpdateColliders
	
	If SGD.GetCollisionCount (camera_collider)
		walking = 1
		camera_ys = 0.0
	EndIf

	' Text...
	
	SGD.Clear2D
	
	Util.ShadowText "SPACE to toggle walk/fly mode: " + Util.MoveMode (walking), 20, 20
	
	' Render/show!
	
	SGD.RenderScene
	SGD.Present
	
Until quit

SGD.Terminate()

'exit_(0)

End

' Utility functions...

Type Util

	' Reduce value towards 0 by amount (eg. 0.01)...
	
	Function Diminish:Double (value:Double, amount:Double)
		If Abs (value) <= Abs (amount) Then Return 0.0
		value = value - (amount * Sgn (value))
		Return value
	End Function

	Function ShadowText (msg:String, x:Float, y:Float, offset:Float = 1.0)
	
		SGD.Set2DTextColor 0.0, 0.0, 0.0, 0.9
		SGD.Draw2DText msg, x + offset, y + offset
		SGD.Set2DTextColor 1.0, 1.0, 1.0, 1.0
		SGD.Draw2DText msg, x, y
		
	End Function
	
	Function MoveMode:String (mode:Int)
		If mode Return "Walking"
		Return "Flying"
	End Function
	
End Type

Function CreateDebugPointLight:Int (Scale:Float = 1.0)

	Local light:Int = SGD.CreatePointLight ()
	
	Local light_debug_mesh:Int = SGD.LoadMesh ("neodemo/media/debuglight.gltf")'CreateConeMesh (1, 0.25, 6, SGD.CreatePrelitMaterial ())
	Local light_debug:Int = SGD.CreateModel (light_debug_mesh)

	SGD.FitMesh light_debug_mesh, -Scale * 0.5, -Scale * 0.5, -Scale * 0.5, Scale * 0.5, Scale * 0.5, Scale * 0.5, True
	SGD.SetMeshShadowsEnabled light_debug_mesh, False
	SGD.SetEntityParent light_debug, light
	
	Return light
	
End Function

Function CreateDebugDirectionalLight:Int (Scale:Float = 1.0)

	Local light:Int = SGD.CreateDirectionalLight ()
	
	Local light_debug_mesh:Int = SGD.LoadMesh ("neodemo/media/debuglight.gltf")'CreateConeMesh (1, 0.25, 6, SGD.CreatePrelitMaterial ())
	Local light_debug:Int = SGD.CreateModel (light_debug_mesh)

	SGD.FitMesh light_debug_mesh, -Scale * 0.5, -Scale * 0.5, -Scale * 0.5, Scale * 0.5, Scale * 0.5, Scale * 0.5, True
	SGD.SetMeshShadowsEnabled light_debug_mesh, False
	SGD.SetEntityParent light_debug, light
	
	Return light
	
End Function

Function CreateDebugSpotLight:Int (Scale:Float = 1.0)

	Local light:Int = SGD.CreateSpotLight ()

	Local light_debug_mesh:Int = SGD.LoadMesh ("neodemo/media/debuglight.gltf")'CreateConeMesh (1, 0.25, 6, SGD.CreatePrelitMaterial ())
	Local light_debug:Int = SGD.CreateModel (light_debug_mesh)

	SGD.FitMesh light_debug_mesh, -Scale * 0.5, -Scale * 0.5, -Scale * 0.5, Scale * 0.5, Scale * 0.5, Scale * 0.5, True
	SGD.SetMeshShadowsEnabled light_debug_mesh, False
	SGD.SetEntityParent light_debug, light
	
	Return light
	
End Function
