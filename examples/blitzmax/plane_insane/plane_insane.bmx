
'	KEYS:

' 	WASD				- forward/back/strafe
' 	CURSORS				- turn/look around
'	LEFT-SHIFT			- speed boost

' Set CAMERA_PITCH_INVERT to True to invert pitch control

Include "../sgd.bmx"

Const FULL_SCREEN:Int = False

Const CAMERA_PITCH_INVERT:Int = False

SGD.LoadSGD "../../../lib/sgd_dynamic.dll"

SGD.Init

Local music:Int = SGD.LoadSound ("plane_insane.mp3")

Local music_stream:Int = SGD.PlaySound (music)

SGD.SetAudioVolume music_stream, 0.5
SGD.SetAudioLooping music_stream, True

Local flags:Int = SGD.WINDOW_FLAGS_RESIZABLE

If FULL_SCREEN
	flags = SGD.WINDOW_FLAGS_FULLSCREEN
EndIf

SGD.CreateWindow (1280, 720, "Plane Insane - WASD/Shift plus CURSORS and... I!", flags)

Local fixed_ground_material_path:String = "sgd://materials/PavingStones065_1K-JPG"
Local fixed_ground_material:Int = SGD.LoadPBRMaterial (fixed_ground_material_path)

Local fixed_plane:Int = SGD.CreatePlane (fixed_ground_material)

SGD.SetEntityVisible fixed_plane, False

Local ground_material_path:String [4]

ground_material_path [0] = "sgd://materials/Ground037_1K-JPG"
ground_material_path [1] = "sgd://materials/Tiles093_1K-JPG"
ground_material_path [2] = "sgd://materials/Gravel023_1K-JPG"
ground_material_path [3] = "sgd://materials/Bricks076C_1K-JPG"

Local ground_material:Int [2]

ground_material [0] = SGD.LoadPBRMaterial (ground_material_path [0])
ground_material [1] = SGD.LoadPBRMaterial (ground_material_path [1])
ground_material [2] = SGD.LoadPBRMaterial (ground_material_path [2])
ground_material [3] = SGD.LoadPBRMaterial (ground_material_path [3])

Local plane:Int [8]

plane [0] = SGD.CreatePlane (ground_material [0])
plane [1] = SGD.CreatePlane (ground_material [0])

plane [2] = SGD.CreatePlane (ground_material [1])
plane [3] = SGD.CreatePlane (ground_material [1])

plane [4] = SGD.CreatePlane (ground_material [2])
plane [5] = SGD.CreatePlane (ground_material [2])

plane [6] = SGD.CreatePlane (ground_material [3])
plane [7] = SGD.CreatePlane (ground_material [3])

Local p0:Int = SGD.CreateModel (Null)
Local p1:Int = SGD.CreateModel (Null)
Local p2:Int = SGD.CreateModel (Null)
Local p3:Int = SGD.CreateModel (Null)

' Planes have one side, so create some double-sided composite planes!

SGD.TurnEntity plane [0], 0, 0, 0		' Faces up
SGD.TurnEntity plane [1], 0, 0, 180		' Faces down

	' Now attach these oppositely-inverted planes to a parent 'plane' entity so they can be rotated as one unit:
	
	SGD.SetEntityParent plane[0], p0
	SGD.SetEntityParent plane[1], p0

SGD.TurnEntity plane [2], 0, 0, 45
SGD.TurnEntity plane [3], 0, 0, 225

	SGD.SetEntityParent plane[2], p1
	SGD.SetEntityParent plane[3], p1

SGD.TurnEntity plane [4], 0, 0, 90
SGD.TurnEntity plane [5], 0, 0, 270

	SGD.SetEntityParent plane[4], p2
	SGD.SetEntityParent plane[5], p2

SGD.TurnEntity plane [6], 0, 0, 135
SGD.TurnEntity plane [7], 0, 0, 315

	SGD.SetEntityParent plane[6], p3
	SGD.SetEntityParent plane[7], p3

SGD.SetAmbientLightColor 0.025, 0.05, 0.0375, 1.0

Local sky_map_path:String			= "sgd://envmaps/nightsky-cube.png"

Local sky_texture:Int = SGD.LoadCubeTexture (sky_map_path, SGD.TEXTURE_FORMAT_ANY, SGD.TEXTURE_FLAGS_DEFAULT)

SGD.SetEnvTexture sky_texture

Local skybox:Int = SGD.CreateSkybox (sky_texture)

'SGD.SetSkyboxRoughness skybox, 0.3

Local camera:Int = SGD.CreatePerspectiveCamera ()

SGD.SetCameraNear camera, 0.05		' Allow extreme closeups!
SGD.SetCameraFar camera, 10000		' Bad!
SGD.MoveEntity camera, 5, 2.5, 0

Local light:Int = SGD.CreatePointLight ()

SGD.SetLightRange light, 100.0
SGD.SetLightShadowsEnabled (light, True) ' CASTING SHADOW
SGD.SetLightColor light, 1.0, 1.0, 1.0, 1.0

SGD.SetEntityParent light, camera

SGD.MoveEntity light, 0, 0, 0

Local fog:Int = SGD.CreateFogEffect ()
SGD.SetFogEffectRange fog, 10, 750 ' TODO: 10, 75 looks wrong
SGD.SetFogEffectColor fog, 0, 0.01, 0.2, 1

Local mono:Int = SGD.CreateMonocolorEffect ()
SGD.SetRenderEffectEnabled mono, False

' Window events variables...

Local events:Int
Local quit:Int = False

' Camera movement variables...

Local pitch:Double = 0.0
Local yaw:Double = 0.0
Local strafe:Double = 0.0
Local rise:Double = 0.0
Local z:Double = 0.0

Local sane:Int = 1
Local sanity:String

Local insanity_enabled:Int = 0

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
	
	If SGD.IsKeyDown (SGD.KEY_LEFT_SHIFT)
		shifted = 2.0
	EndIf
	
	' A/D keys: strafe left/right...

	If SGD.IsKeyDown (SGD.KEY_A)
		strafe = strafe - 0.01 * shifted
		If strafe < -0.1 * shifted Then strafe = -0.1 * shifted
	Else
		If SGD.IsKeyDown (SGD.KEY_D)
			strafe = strafe + 0.1 * shifted
			If strafe > 0.1 * shifted Then strafe = 0.1 * shifted
		EndIf
	EndIf

	' W/S keys: forward/back...

	If SGD.IsKeyDown (SGD.KEY_W)
		z = z + 0.01 * shifted
		If z > 0.1 * shifted Then z = 0.1 * shifted
	Else
		If SGD.IsKeyDown (SGD.KEY_S)
			z = z - 0.01 * shifted
			If z < -0.1 * shifted Then z = -0.1 * shifted
		EndIf
	EndIf

	If SGD.IsKeyHit (SGD.KEY_I)
		If Not insanity_enabled
			insanity_enabled = True
			SGD.SetEntityVisible fixed_plane, True
		EndIf
		sane = 1 - sane
	EndIf

	' Diminish all movement towards 0...
	
	pitch	= Util.Diminish (pitch, 0.03)
	yaw		= Util.Diminish (yaw, 0.03)
	strafe	= Util.Diminish (strafe, 0.0015)
	rise	= Util.Diminish (rise, 0.0015)
	z		= Util.Diminish (z, 0.0015)

	' Update camera...
	
	SGD.TurnEntity camera, pitch, 0, 0
	SGD.RotateEntity camera, 0, yaw, 0
	SGD.MoveEntity camera, strafe, rise, z
	
	If Not sane

		SGD.TurnEntity p0, 0.05, -0.05, 0.005
		SGD.TurnEntity p1, 0.025, 0.05, -0.333

		SGD.TurnEntity p2, -0.05, 0.05, 0.05
		SGD.TurnEntity p3, -0.015, 0.025, 0.0125

		SGD.SetRenderEffectEnabled mono, False

		Local ticks:Int = MilliSecs ()
		Local r:Float = Abs (Sin (ticks * 0.01))
		Local g:Float = Abs (Sin (ticks * 0.025))
		Local b:Float = Abs (Sin (ticks * 0.05))

		SGD.SetMonocolorEffectColor mono, r, g, b, 1.0
		SGD.SetRenderEffectEnabled mono, True

	EndIf

	SGD.TurnEntity skybox, 0.1, 0.2, 0.3

	If sane
		sanity = "On"
		SGD.SetRenderEffectEnabled mono, False
	Else
		sanity = "Off"
		SGD.SetRenderEffectEnabled mono, True
	EndIf
	
	SGD.Clear2D
	Util.ShadowText "I - Toggle sanity: " + sanity, 10, 10
	
	' Render/show!
	
	SGD.RenderScene
	SGD.Present

Until quit

SGD.Terminate()

End

' Utility functions...

Type Util

	' Just to tidy up Rnd Double warnings!

	Function RndF:Float (minValue:Float = 1, maxValue:Float = 0)
		Return Float (Rnd (minValue, maxValue))
	End Function

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
	
End Type

' No doubt to come!

Function temp_EntityDistance:Float (src:Int, dest:Int)
	Return Sqr ((SGD.GetEntityX (src) - SGD.GetEntityX (dest)) ^ 2 + (SGD.GetEntityY (src) - SGD.GetEntityY (dest)) ^ 2 + (SGD.GetEntityZ (src) - SGD.GetEntityZ (dest)) ^ 2)
End Function
