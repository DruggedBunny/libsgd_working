





' TODO: Create separate water particles!
' TODO: Make entity markers update position! Duh...


' Island of the Emplanted: a pseudo eco-blaster

' "What better way to save the planet than BLOW IT UP?" (With trees.)

' CODE IS A MESS AT PRESENT, SORRY!

'	KEYS:

' 	WASD				- forward/back/strafe
' 	CURSORS				- turn/look around
'	LEFT-SHIFT			- speed boost
'	SPACE				- Shoot

' Set Camera_PITCH_INVERT to True to invert pitch control

Include "../sgd.bmx"

Const FULL_SCREEN:Int = False
Const CAMERA_PITCH_INVERT:Int = False ' True to flip look-up/down on Xbox pad

Const EXPLOSION_PARTICLES_LOW:Int	= 100
Const EXPLOSION_PARTICLES_MED:Int	= 500
Const EXPLOSION_PARTICLES_HIGH:Int	= 1000

Const EXPLOSION_PARTICLES_MAX:Int = EXPLOSION_PARTICLES_MED

Const CONTROL_KEYBOARD:Int = 1
Const CONTROL_GAMEPAD:Int = 2 ' Basically assuming Xbox360+!

Const CONTROL_GAMEPAD_AXIS_YAW:Int = 0
Const CONTROL_GAMEPAD_AXIS_STRAFE:Int = 2
Const CONTROL_GAMEPAD_AXIS_PITCH:Int = 3

Const CONTROL_GAMEPAD_AXIS_ACCELERATE:Int = 4
Const CONTROL_GAMEPAD_AXIS_BRAKE:Int = 5

Const CONTROL_GAMEPAD_ID:Int = 0

Const CONTROLLER:Int = CONTROL_KEYBOARD
'Const CONTROLLER:Int = CONTROL_GAMEPAD

' TURN SOUNDS OFF HERE!

Const SOUNDS_ON:Int = True
Const MUSIC_ON:Int = True

Const COLLIDE_CAMERA:Int			= 1
Const COLLIDE_LAND:Int				= 2
Const COLLIDE_BULLET:Int			= 4

Global Gravity:Float = -0.005

SGD.LoadSGD "../../../lib/sgd_dynamic.dll"	' Load BlitzMax NG DLL wrapper
SGD.Init						' Normal SGD setup call

'SGD.SetWebGPUBackend "D3D12"
'SGD.SetWebGPUBackend "Vulkan" ' Keyboard events seem to pile up and then execute, eg. pressing up pauses, then starts moving and if left/right is pressed, the up events seem to process before l/r takes effect
' Uncomment to force Vulkan instead of the default (D3D12 on Windows 10/11):
'SGD.SetConfigVar "dawn.backendType", "Vulkan"

' Long startup pause (white screen, music playing) with default GPU renderer on 11

' Lot of pauses on creating explosions, especially first one, even with SOUNDS_ON = False
' Does 'pre-load' and draw the explosion/smoke images at startup

' --------
' WINDOW:
' --------

SGD.CreateWindow (1280, 720, "Island of the Emplanted WIP Demo - WASD/Shift plus CURSORS and SPACE", SGD.WINDOW_FLAGS_CENTERED)

' --------
' SOUNDS:
' --------

Global Sound_Music:Int		' Tunez
Global Sound_Shot:Int		' Bullet
Global Sound_Boom:Int [7]	' Booms
Global Sound_Fall:Int [2]	' Random falling particles (not great)

If SOUNDS_ON
	
	Sound_Music = SGD.LoadSound ("media/synthynverbd.mp3")
	
	' All sounds generated on Behringer Edge analog synth!
	
	' Use under Zlib/PNG license to match LibSGD.
	
	Sound_Shot = SGD.LoadSound ("media/shot.ogg")
	
	For Local num:Int = 0 Until 7
		Sound_Boom [num] = SGD.LoadSound ("media/boom" + (num + 1) + ".ogg")
'		Sound_Boom [num] = SGD.LoadSound ("media/new_booms/new_boom-" + ((num + 100) + 1) + ".ogg")
	Next
	
	For Local num:Int = 0 Until 2
		Sound_Fall [num] = SGD.LoadSound ("media/fall" + (num + 1) + ".ogg")
	Next
	
EndIf

' -------
' SCENE:
' -------

' Colours/Colors!

' This Color type is created with 0-255 to interpret against Paint, etc; holds 0.0-1.0 values once created:

Local cls_color:Color		= New Color (38.25, 76.5, 204)
Local ambient_color:Color	= New Color (3.1875, 6.375, 4.4625)
Local sunlight_color:Color	= New Color (216.75, 216.75, 165.75)

' Underwater lighting... wooooOOOOOoooo...

Local cls_underwater_color:Color		= New Color (12.75, 12.75, 76.5)
Local ambient_underwater_color:Color	= New Color (0.255, 0.255, 1.9125)
Local sunlight_underwater_color:Color	= New Color (19.125, 19.125, 31.875)

Util.SetClearColor			cls_color
Util.SetAmbientLightColor	ambient_color

' SHADOW MAP STUFF!

Rem

https://www.patreon.com/posts/106478517

OK, I have it working although there are issues that still need to be sorted out, in particular 'peter panning' and 'acne':
https://digitalrune.github.io/DigitalRune-Documentation/html/3f4d959e-9c98-4a97-8d85-7a73c26145d7.htm
The important bit you missed is setting the CSM 'split distances', check the v0.08 post again. This describes how the frustum is sliced up and will depend greatly on far clipping distance and style of game. Since your far clip plane is 2000 I tried the following and it works pretty well to start with:
SGD.SetCSMSplitDistances 100, 250, 500, 2000
SGD.SetCSMTextureSize 2048
The last distance should generally the same as far clip plane, and the others should increment in size. You'll need to experiment with these for the best results! Shadows will always stop at the last distance you provide, so if you set this to one of the other distances you can get a visual indication where that split ends in the 'real virtual world'.
100 Would be way to high for the nearest distance in a 'walking around on the ground' style game (csmcubes uses 8 I think!) so in some case making split distances dynamic might even be useful. Perhaps in a game like this, near split should be proprtional to height of camera off ground, or maybe min of that and a LinePick, just throwing ideas around! Fortunately, there's no real overhead to changing these in real time...
Most terrain-based game don't actually use CSM shadows, although they will still be used for characters and vehicles and possibly even buildings etc, but the terrain itself will often use a pre-generated shadow map. Dynamic shadow mapping will never been quite perfect, and this can be super obvious on something as large as a terrain.
But it's definitely worth making this demo look as nice as possible as it'll just improve everything else.

End Rem

'SGD.SetCSMSplitDistances 100, 250, 500, 2000
'SGD.SetCSMTextureSize 2048

SGD.SetConfigVar "csm.splitDistances", "100,250,500,2000"
SGD.SetConfigVar "csm.textureSize", "2048"

' -------
' LIGHT:
' -------

'SGD.SetMaxPSMLights 8'32

' Create a point light -- LibSGD doesn't yet support spotlight shadows:

Const LIGHT_DEBUG:Int = 1
Const LIGHT_DIRECTIONAL:Int = 2

'Local light_type:Int = LIGHT_DEBUG
Local light_type:Int = LIGHT_DIRECTIONAL

Local sun_light:Int

Select light_type

	Case LIGHT_DEBUG
		sun_light = CreateDebugPointLight (5) ' Model size; default = 1
	Case LIGHT_DIRECTIONAL
		sun_light = CreateDebugDirectionalLight (5)

	Default
		SGD.Error "Unknown light type in light setup!"
		
End Select

' Light details:

'SGD.SetPSMTextureSize 2048
SGD.SetConfigVar "psm.textureSize", "2048"

'SGD.SetLightRange sun_light, 5000.0
SGD.SetLightShadowsEnabled (sun_light, True) ' CASTING SHADOW
Util.SetLightColor sun_light, sunlight_color

SGD.SetLightPriority sun_light, 10

' Pivot and positioning:
Local light_pivot:Int = SGD.CreateModel (0)

' Attach to pivot so we can spin it around the map in main loop...

SGD.MoveEntity sun_light, 0, 0, -350

SGD.SetEntityParent sun_light, light_pivot

'SGD.TurnEntity light_pivot, -60, 0, 0

'SGD.TurnEntity sun_light, -22.5, 0, 0

Local sun_rotation_speed:Float = 0.1

SGD.AimEntityAtPoint sun_light, 0.0, 0.0, 0.0, 0.0

'Local sun_rotation_speed:Float = 
' ------
' LAND:
' ------

Local land_mesh:Int = SGD.LoadMesh ("media/land.gltf")
Local land_model:Int = SGD.CreateModel (land_mesh)

SGD.FitMesh land_mesh, -250, -35, -250, 250, 35, 250, False
SGD.SetMeshShadowsEnabled land_mesh, True

Global LandCollider:Int = SGD.CreateMeshCollider (land_model, COLLIDE_LAND, land_mesh)
'Print "Land: " + LandCollider

' -------
' WATER:
' -------

Local water_mesh:Int = SGD.LoadMesh ("media/water.gltf")
Local water:Int = SGD.CreateModel (water_mesh)

Global WaterLevel:Double = SGD.GetEntityY (water)

SGD.FitMesh water_mesh, -1000, -1, -1000, 1000, 1, 1000, True
SGD.MoveEntity water, 0, -17.5, 0

' --------
' Camera:
' --------

Global Camera:Int = SGD.CreatePerspectiveCamera ()

Global CameraRange:Double = 2000
SGD.SetCameraFar Camera, Float (CameraRange)

SGD.MoveEntity Camera, 0, 50, -250

' Think these might just be points lights in v0.08.1?
'Local camera_light:Int = SGD.CreateSpotLight ()
'SGD.TurnEntity camera_light, -90, 0, 0
'SGD.SetLightRange camera_light, 100.0
'SGD.SetLightInnerConeAngle camera_light, 2.0
'SGD.SetLightOuterConeAngle camera_light, 5.0
'SGD.SetEntityParent camera_light, Camera

Local camera_collider:Int = SGD.CreateSphereCollider (Camera, COLLIDE_CAMERA, 2.0)
'Print "Cam: " + camera_collider

' -----------
' COLLIDERS:
' -----------

SGD.EnableCollisions COLLIDE_CAMERA, COLLIDE_LAND, SGD.COLLISION_RESPONSE_SLIDE
SGD.EnableCollisions COLLIDE_BULLET, COLLIDE_LAND, SGD.COLLISION_RESPONSE_STOP

' Pre-load explosion sprite:

Explosion.Preload
Smoke.Preload

' Window events variables...

Local events:Int
Local quit:Int = False

' Camera movement variables...

Local pitch:Double = 0.0
Local yaw:Double = 0.0
Local strafe:Double = 0.0
Local z:Double = 0.0

Local move_speed:Double = 0.05
Local pitch_speed:Double = 0.03
Local yaw_speed:Double = 0.03

If SOUNDS_ON And MUSIC_ON
	Local music_stream:Int = SGD.CueSound (Sound_Music)
	SGD.SetAudioVolume music_stream, 0.1
	SGD.SetAudioLooping music_stream, True
	SGD.SetAudioPaused music_stream, False
EndIf

Global TreeMeshes:Int [3]

TreeMeshes[0] = SGD.LoadMesh ("sgd://models/tree1.glb")
TreeMeshes[1] = SGD.LoadMesh ("sgd://models/palm_tree1.glb")
TreeMeshes[2] = SGD.LoadMesh ("sgd://models/birch_tree1.glb")

SGD.SetMeshShadowsEnabled TreeMeshes[0], True
SGD.SetMeshShadowsEnabled TreeMeshes[1], True
SGD.SetMeshShadowsEnabled TreeMeshes[2], True

SGD.SetLightRange sun_light, 2000.0
SGD.SetLightFalloff sun_light, 0.0

' Pitch inversion option...

Local pitcher:Float = 1.0
If CAMERA_PITCH_INVERT Then pitcher = -1.0
	
Repeat

	' Get window events...
	
	events = SGD.PollEvents ()
	
	' Check for ESC key or window close gadget-hit...
	
	If SGD.IsKeyHit (SGD.KEY_ESCAPE) Or events & SGD.EVENT_MASK_CLOSE_CLICKED
		quit = True
	EndIf
	
	If CONTROLLER = CONTROL_KEYBOARD

		If SGD.IsKeyHit (SGD.KEY_SPACE)
			If SOUNDS_ON Then SGD.PlaySound (Sound_Shot)
			New Bullet z
		EndIf
		
		' LEFT/RIGHT cursors: Camera strafe...
	
		If SGD.IsKeyDown (SGD.KEY_LEFT)
			yaw = yaw + yaw_speed
			If yaw > 1.5 Then yaw = 1.5
		Else
			If SGD.IsKeyDown (SGD.KEY_RIGHT)
				yaw = yaw - yaw_speed
				If yaw < -1.5 Then yaw = -1.5
			EndIf
		EndIf

		If SGD.IsKeyDown (SGD.KEY_UP)
			pitch = pitch - pitch_speed * pitcher
			If pitch < -1.5 Then pitch = -1.5
		Else
			If SGD.IsKeyDown (SGD.KEY_DOWN)
				pitch = pitch + pitch_speed * pitcher
				If pitch > 1.5 Then pitch = 1.5
			EndIf
		EndIf

		' Camera boost with LEFT SHIFT...
		
		Local shifted:Float = 1.0
		
		If SGD.IsKeyDown (SGD.KEY_LEFT_SHIFT)
			shifted = 2.0
		Else
			If SGD.IsKeyDown (SGD.KEY_LEFT_CONTROL)
				shifted = 0.5
			EndIf
		EndIf
		
		' A/D keys: strafe left/right...

		If SGD.IsKeyDown (SGD.KEY_A)
			strafe = strafe - move_speed * shifted
		Else
			If SGD.IsKeyDown (SGD.KEY_D)
				strafe = strafe + move_speed * shifted
			EndIf
		EndIf

		' W/S keys: forward/back...

		If SGD.IsKeyDown (SGD.KEY_W)
			z = z + move_speed * shifted
		Else
			If SGD.IsKeyDown (SGD.KEY_S)
				z = z - move_speed * shifted
			EndIf
		EndIf

	Else

		If CONTROLLER = CONTROL_GAMEPAD And SGD.IsGamepadConnected (CONTROL_GAMEPAD_ID)

			If SGD.IsGamepadButtonHit (CONTROL_GAMEPAD_ID, SGD.GAMEPAD_BUTTON_A)
				If SOUNDS_ON Then SGD.PlaySound (Sound_Shot)
				New Bullet z
			EndIf

			Local yaw_axis:Float = SGD.GetGamepadAxis (CONTROL_GAMEPAD_ID, CONTROL_GAMEPAD_AXIS_STRAFE)
			If Abs (yaw_axis) > 0.15 Then yaw = yaw - yaw_axis * 0.05

			Local pitch_axis:Float = SGD.GetGamepadAxis (CONTROL_GAMEPAD_ID, CONTROL_GAMEPAD_AXIS_PITCH) * -pitcher
			If Abs (pitch_axis) > 0.15 Then pitch = pitch - pitch_axis * 0.04

			' Acceleration...
			Local z_axis:Float = 0.3 * (SGD.GetGamepadAxis (CONTROL_GAMEPAD_ID, CONTROL_GAMEPAD_AXIS_ACCELERATE) - SGD.GetGamepadAxis (CONTROL_GAMEPAD_ID, CONTROL_GAMEPAD_AXIS_BRAKE))
			If Abs (z_axis) > 0.15 Then z = z - z_axis * 0.05

			Local strafe_axis:Float = 0.4 * SGD.GetGamepadAxis (CONTROL_GAMEPAD_ID, CONTROL_GAMEPAD_AXIS_YAW)
			If Abs (strafe_axis) > 0.15 Then strafe = strafe + strafe_axis * 0.05

		EndIf
	
	EndIf
	
	If SGD.IsKeyDown (SGD.KEY_LEFT_BRACKET)
		sun_rotation_speed = sun_rotation_speed - 0.01
		If sun_rotation_speed < 0.0 Then sun_rotation_speed = 0.0
	Else
		If SGD.IsKeyDown (SGD.KEY_RIGHT_BRACKET)
			sun_rotation_speed = sun_rotation_speed + 0.01
			If sun_rotation_speed > 5.0 Then sun_rotation_speed = 5.0
		EndIf
	EndIf
	
	' Diminish all movement towards 0...
	
	pitch	= Util.DiminishByPercentage (pitch, 97.5)
	yaw		= Util.DiminishByPercentage (yaw, 97.5)
	strafe	= Util.DiminishByPercentage (strafe, 97.5)
	z		= Util.DiminishByPercentage (z, 97.0)

	' Update Camera...
	
	SGD.TurnEntity Camera, pitch, 0, 0
	SGD.RotateEntity Camera, 0, yaw, 0
	SGD.MoveEntity Camera, strafe, 0, z

	' Move water and light...
	
	SGD.MoveEntity water, 0, 0.025 * Sin (0.1 * MilliSecs ()), 0
	
'	SGD.TranslateEntity sun_light, 0, Sin (0.005 * MilliSecs ()) * 0.1, 0

	
'	SGD.TurnEntity light_pivot, 0.0, 0.1, 0.0

	Local sin_angle:Float = Sin (SGD.GetEntityRY (light_pivot))
'	Print sin_angle
	
	SGD.SetEntityRotation light_pivot, Util.TransformRange (sin_angle, -1.0, 1.0, -5.0, -75.0), SGD.GetEntityRY (light_pivot) + sun_rotation_speed, 0.0
	'SGD.RotateEntity light_pivot, Util.TransformRange (sin_angle, -1.0, 1.0, ), 0.1, 0.0
	
	SGD.AimEntityAtPoint sun_light, 0.0, 0.0, 0.0, 0.0

	' Scale from -1 to +1 over to 0 to 1...
'	sin_angle = (sin_angle + 1) * 0.5
	sin_angle = Util.TransformRange (sin_angle, -1.0, 1.0, 0.75, 1.0)
'	Print sin_angle
'	Print ""
	
	WaterLevel = SGD.GetEntityY (water)

	If SGD.GetEntityY (Camera) > SGD.GetEntityY (water)

		' Above water, reset lighting...
		
		Util.SetClearColor				cls_color, sin_angle
		Util.SetAmbientLightColor		ambient_color, sin_angle
		Util.SetLightColor sun_light,	sunlight_color, sin_angle

' TMP disabled
'		SGD.SetLightRange sun_light, 10000.0

	Else

		' Underwater lighting!

		Util.SetClearColor				cls_underwater_color, sin_angle
		Util.SetAmbientLightColor		ambient_underwater_color, sin_angle
		Util.SetLightColor sun_light,	sunlight_underwater_color, sin_angle

' TMP disabled
'		SGD.SetLightRange sun_light, 2000.0

	EndIf
	
	SGD.UpdateColliders
	
	Bullet.Update
	Explosion.Update
	Smoke.Update
	DelayedExplosionSound.Update
	
	' Text
	
'	SGD.Clear2D
'	SGD.Draw2DText msg, x, y

	SGD.Clear2D
	
	Util.ShadowText "FPS: " + SGD.GetFPS (), 20, 20
	Util.ShadowText "Explosion sprites: " + ExplosionSprite.Count, 20, 40
	Util.ShadowText "Smoke sprites: " + SmokeSprite.Count, 20, 60
	Util.ShadowText "Sun rotation speed - modify with [ and ]:" + Util.TrimDouble (sun_rotation_speed), 20, 100

	' Crosshair...
	
	Util.DrawCrosshair
	
	EntityMarker.UpdateAll
	
	' Render/show!

	SGD.RenderScene
	SGD.Present

Until quit

SGD.Terminate ' Doesn't exit on 11 without this

End

' Color uses (float) 0-255 for creation only...

Type Color

	Field r:Float
	Field g:Float
	Field b:Float
	Field a:Float
	
	' Takes floats from 0-255 just for creation purposes. Values are SGD-friendly 0.0 to 1.0 once created.
	
	Method New (red:Float = 0.0, green:Float = 0.0, blue:Float = 0.0, alpha:Float = 1.0)

		If red < 0		Or red > 255	Then SGD.Error "New Color: Red out of range, must be 0-255!"
		If green < 0	Or green > 255	Then SGD.Error "New Color: Green out of range, must be 0-255!"
		If blue < 0		Or blue > 255	Then SGD.Error "New Color: Blue out of range, must be 0-255!"
		If alpha < 0	Or alpha > 1.0	Then SGD.Error "New Color: Alpha out of range, must be 0.0 to 1.0!"

		r = red		/ 255.0
		g = green	/ 255.0
		b = blue	/ 255.0
		
		a = alpha

	End Method
	
End Type

' Utility functions...

Type Util

	Function SetClearColor (c:Color, multiplier:Float = 1.0)
		SGD.SetClearColor c.r * multiplier, c.g * multiplier, c.b * multiplier, c.a * multiplier
	End Function
	
	Function SetLightColor (light:Int, c:Color, multiplier:Float = 1.0)
		SGD.SetLightColor light, c.r * multiplier, c.g * multiplier, c.b * multiplier, c.a * multiplier
	End Function
	
	Function SetAmbientLightColor (c:Color, multiplier:Float = 1.0)
		SGD.SetAmbientLightColor c.r * multiplier, c.g * multiplier, c.b * multiplier, c.a * multiplier
	End Function
	
	Function ShadowText (msg:String, x:Float, y:Float, offset:Float = 1.0)
	
		SGD.Set2DTextColor 0.0, 0.0, 0.0, 0.9
		SGD.Draw2DText msg, x + offset, y + offset
		SGD.Set2DTextColor 1.0, 1.0, 1.0, 1.0
		SGD.Draw2DText msg, x, y
		
	End Function
	
	Function ShadowLine (x0:Float, y0:Float, x1:Float, y1:Float, offset:Float = 1.0)
	
		SGD.Set2DFillColor 0.0, 0.0, 0.0, 0.9
		SGD.Draw2DLine x0 + offset, y0 + offset, x1 + offset, y1 + offset
		SGD.Set2DFillColor 1.0, 1.0, 1.0, 1.0
		SGD.Draw2DLine x0, y0, x1, y1
		
	End Function

	Function DrawCrosshair ()
	
		Local ww:Float = SGD.GetWindowWidth () / 2
		Local wh:Float = SGD.GetWindowHeight () / 2
		
		Util.ShadowLine ww - 5, wh, ww + 5, wh
		Util.ShadowLine ww, wh - 5, ww, wh + 5
		
	End Function
	
	' Just to tidy up bmx-ng Rnd Double warnings!

	Function RndF:Float (minValue:Float = 1, maxValue:Float = 0)
		Return Float (Rnd (minValue, maxValue))
	End Function

	' Reduce value towards 0 by amount (eg. 0.01)...
	
	Function Diminish:Double (value:Double, amount:Double)
		If Abs (value) <= Abs (amount) Then Return 0.0
		Return value - (amount * Sgn (value))
	End Function

	' Ugh! Tailored for demo movement...

	Function DiminishByPercentage:Double (value:Double, percentage:Double, minimum:Double = 0.001)
		If percentage < 0.0 Then SGD.Error "DiminishByPercentage percentage param must be > 0.0!"
		If minimum <= 0.0 Then minimum = 0.001; SGD.Error "DiminishByPercentage minimum param must be > 0.0!"
		percentage = percentage / 100.0
		Local result:Double = value * percentage
		If Abs (result) > minimum Then Return result Else Return 0.0
	End Function

	Function Distance:Float (src_x:Double, src_y:Double, src_z:Double, dest_x:Double, dest_y:Double, dest_z:Double)
		Return Sqr ((src_x - dest_x) ^ 2 + (src_y - dest_y) ^ 2 + (src_z - dest_z) ^ 2)
	End Function

	Function TransformRange:Float (input_value:Float, from_min:Float, from_max:Float, to_min:Float, to_max:Float)

		' Algorithm via jerryjvl at https://stackoverflow.com/questions/929103/convert-a-number-range-to-another-range-maintaining-ratio
		
		Local from_delta:Float	= from_max	- from_min	' Input range,	eg. 0.0 - 1.0
		Local to_delta:Float	= to_max	- to_min	' Output range,	eg. 5.0 - 10.0
		
		If from_delta = 0.0 Then SGD.Error "TransformRange: Invalid input range!"
		
		Return (((input_value - from_min) * to_delta) / from_delta) + to_min
		
	End Function

	Function TrimDouble:String (num:Double, places:Int = 2)
		Local n:String = num
		Local pos:Int = Instr (n, ".")
		If pos
			n = n [..pos] + n [pos..pos + places] ' Don't think this is right... and leaves .00 instead of .0, but hey-ho
		EndIf
		Return n
	End Function
	
End Type

' No doubt to come!

Function temp_EntityDistance:Float (src:Int, dest:Int)
	Return Sqr ((SGD.GetEntityX (src) - SGD.GetEntityX (dest)) ^ 2 + (SGD.GetEntityY (src) - SGD.GetEntityY (dest)) ^ 2 + (SGD.GetEntityZ (src) - SGD.GetEntityZ (dest)) ^ 2)
End Function

Function CreateSkyBox ()

	Local sky_map_path:String = "sgd://envmaps/sunnysky-cube.png"

	Local sky_texture:Int = SGD.LoadCubeTexture (sky_map_path, SGD.TEXTURE_FORMAT_SRGBA8, SGD.TEXTURE_FLAGS_MIPMAP | SGD.TEXTURE_FLAGS_FILTER)
	Local skybox:Int = SGD.CreateSkybox (sky_texture)

	SGD.SetEnvTexture sky_texture
	SGD.SetSkyboxRoughness skybox, 0.3

End Function

Function CreateDebugPointLight:Int (Scale:Float = 1.0)

	Local light:Int = SGD.CreatePointLight ()
	
	Local light_debug_mesh:Int = SGD.LoadMesh ("media/debuglight.gltf")'CreateConeMesh (1, 0.25, 6, SGD.CreatePrelitMaterial ())
	Local light_debug:Int = SGD.CreateModel (light_debug_mesh)

	SGD.FitMesh light_debug_mesh, -Scale * 0.5, -Scale * 0.5, -Scale * 0.5, Scale * 0.5, Scale * 0.5, Scale * 0.5, True
	SGD.SetMeshShadowsEnabled light_debug_mesh, False
	SGD.SetEntityParent light_debug, light
	
	Return light
	
End Function

Function CreateDebugDirectionalLight:Int (Scale:Float = 1.0)

	Local light:Int = SGD.CreateDirectionalLight ()
	
	Local light_debug_mesh:Int = SGD.LoadMesh ("media/debuglight.gltf")'CreateConeMesh (1, 0.25, 6, SGD.CreatePrelitMaterial ())
	Local light_debug:Int = SGD.CreateModel (light_debug_mesh)

	SGD.FitMesh light_debug_mesh, -Scale * 0.5, -Scale * 0.5, -Scale * 0.5, Scale * 0.5, Scale * 0.5, Scale * 0.5, True
	SGD.SetMeshShadowsEnabled light_debug_mesh, False
	SGD.SetEntityParent light_debug, light
	
	Return light
	
End Function

Function CreateDebugSpotLight:Int (Scale:Float = 1.0)

	Local light:Int = SGD.CreateSpotLight ()

	Local light_debug_mesh:Int = SGD.LoadMesh ("media/debuglight.gltf")'CreateConeMesh (1, 0.25, 6, SGD.CreatePrelitMaterial ())
	Local light_debug:Int = SGD.CreateModel (light_debug_mesh)

	SGD.FitMesh light_debug_mesh, -Scale * 0.5, -Scale * 0.5, -Scale * 0.5, Scale * 0.5, Scale * 0.5, Scale * 0.5, True
	SGD.SetMeshShadowsEnabled light_debug_mesh, False
	SGD.SetEntityParent light_debug, light
	
	Return light
	
End Function

Type Bullet

	Global BulletImage:Int
	Global BulletImageFile:String = "sgd://misc/light.png"
	
	Global BulletList:TList
	Global BulletSpeed:Float = 1.0
'	Global BulletDist:Float = 250.0
	
	Field entity:Int
	Field collider:Int
	
	Field light:Int
	Field init_speed:Float
	Field ys:Float
	Field created_time:Int = MilliSecs ()
	
	Method New (speed:Double = 0.0)
	
		If Not BulletList
			BulletList = CreateList ()
		EndIf
		
		If Not BulletImage
			BulletImage = SGD.LoadImage (BulletImageFile)
		EndIf
	
		' Simplify to debug...
		
		light = SGD.CreatePointLight ()

		SGD.SetLightRange light, 20
		SGD.SetLightOuterConeAngle light, 20
		SGD.SetLightShadowsEnabled light, True
		SGD.SetLightPriority light, 5
		
		init_speed = Max (1.7, speed) ' NASTY: 1.7 hard-coded from current max speed!
		
		' Primary!
		
		Local r:Int = Rand (0, 1)
		Local g:Int = Rand (0, 1)
		Local b:Int = Rand (0, 1)

		' Convert black to white!
		
		If Not r And Not g And Not b Then r = 1; g = 1; b = 1
		
'		entity = demo_CreateBullet (0.1)

		entity = SGD.CreateSprite (BulletImage)
		'Local mesh:Int = SGD.CreateBoxMesh (-0.5, -0.5, -0.5, 0.5, 0.5, 0.5, SGD.CreatePbrMaterial ())
		'entity = SGD.CreateModel (mesh)
		SGD.SetSpriteColor entity, 1, 1, 1, 1'r, g, b, 1
		
		SGD.SetEntityParent entity, Camera		' Pick up Camera position/orientation
		SGD.SetEntityParent entity, Null		' Now use world as parent or we follow the Camera!

		' Attach light to bullet...
		
		SGD.SetEntityParent light, entity
		SGD.SetLightColor light, 1, 1, 1, 1'r, g, b, 1.0
		
		' Added to Type to avoid GC... still same
		
		collider = SGD.CreateSphereCollider (entity, COLLIDE_BULLET, 1.5)
		SGD.SetColliderRadius collider, 0.1
		' Maybe move via normal once we can detect collisions?
		
'		collider = SGD.CreateMeshCollider (entity, COLLIDE_BULLET, mesh)
' no difference

		ListAddLast BulletList, Self

	End Method
	
	Function Update ()
	
		If Not BulletList Then Return
		
		For Local b:Bullet = EachIn BulletList
		
			b.ys = b.ys + Gravity
			
			SGD.MoveEntity b.entity, 0, 0, b.init_speed + BulletSpeed
'			SGD.TranslateEntity b.entity, 0, b.ys, 0

			Local ccs:Int = SGD.GetCollisionCount (b.collider)

			Local timed_out:Int = False
			
			If MilliSecs () - b.created_time > 3500
				timed_out = True
			EndIf

			If ccs Or timed_out' Or (temp_EntityDistance (Camera, b.entity) > BulletDist)

				If ccs

					' That turned out to be simpler than expected...
					
					SGD.MoveEntity b.entity, 0, 0, -(b.init_speed + BulletSpeed)

				EndIf
				
				Local explosion_x:Double = SGD.GetEntityX (b.entity)
				Local explosion_y:Double = SGD.GetEntityY (b.entity)
				Local explosion_z:Double = SGD.GetEntityZ (b.entity)

				New DelayedExplosionSound explosion_x, explosion_y, explosion_z

				Local particle_count:Int = EXPLOSION_PARTICLES_MAX
				Local rand_particles:Int = Rand (50, particle_count) ' Needs to be float for calculation
				
				' More particles means bigger explosion...
				
				Local power:Float = 1.2 * Float (rand_particles) / particle_count
				New Explosion explosion_x, explosion_y, explosion_z, Util.RndF (0.25, power), rand_particles
				New Smoke explosion_x, explosion_y, explosion_z, Util.RndF (0.25, power * 0.1), Int (rand_particles * 0.1)

				If Not timed_out
					Local tree_model:Int = SGD.CreateModel (TreeMeshes [Rand (0,2)])
					SGD.MoveEntity tree_model, explosion_x, explosion_y - 1.75, explosion_z
					SGD.TurnEntity tree_model, 0, Rnd (360.0), 0
				EndIf

'				EntityMarker.Create Camera, b.entity, "Particles: " + Int (rand_particles) + " / Power: " + power
				
				' Destroy bullet...
				
				SGD.DestroyEntity b.entity
				b.entity = Null
				
				ListRemove BulletList, b
				
			EndIf

		Next
		
	End Function
	
End Type

' An explosion instance (creates/updates 'ExplosionSprites')...

Type Explosion

	Global ExplosionParticle:Int
	Global ExplosionList:TList		' List of ongoing explosions
	
	Global Lights:Int = True
	Global LightShadows:Int = False
	
	Field sprite_array:ExplosionSprite [] ' Empty array of sprites for this explosion
	
	' Will be set up in New if not called; this stops first pause though!
	
	Function Preload (image:String = "sgd://misc/light.png")
		ExplosionList = CreateList ()
		Local sprite_image:Int = SGD.LoadImage (image)
		ExplosionParticle = SGD.CreateSprite (sprite_image)
		''SGD.SetEntityVisible ExplosionSpriteImage, False
	'	SGD.Draw2DImage ExplosionSpriteImage, 0, 0, 0
'		SGD.Clear2D
	End Function
	
	Method New (x:Double, y:Double, z:Double, power:Float = 0.95, count:Int = 500)

		If Not ExplosionList Then ExplosionList = CreateList ()
		If Not ExplosionParticle Then Preload ()
		
		' Resize array...
		
		sprite_array = New ExplosionSprite [count]
		
		' Assign each sprite in the array...
		
		For Local c:Int = 0 Until count
			sprite_array [c] = New ExplosionSprite (x, y, z, power)
		Next

		' Add current explosion to list of ongoing explosions...
		
		ExplosionList.AddLast Self
		
	End Method
	
	' Update sprites in this explosion...
	
	Method UpdateSprites ()
	
		Local destroyed_count:Int = 0

		For Local loop:Int = 0 Until sprite_array.Length

			' Trying to use shortened es:ExplosionSprite pointer to sprite_array [loop] fails once they start getting removed (entity lost)...
			
			If sprite_array [loop]
			
				sprite_array [loop].ys = sprite_array [loop].ys + Gravity
				
				SGD.MoveEntity sprite_array [loop].entity, 0, 0, sprite_array [loop].power
				SGD.TranslateEntity sprite_array [loop].entity, 0, sprite_array [loop].ys, 0
				
				' TODO: Why TF are you not fading out??
				
				If sprite_array [loop].water
					sprite_array [loop].alpha = Util.DiminishByPercentage (sprite_array [loop].alpha, 95.0, 0.01)
					SGD.SetSpriteColor sprite_array [loop].entity, 1.0, 1.0, 1.0, sprite_array [loop].alpha
				EndIf
				
				' Sprite below water level? It's finished!
				
				If (SGD.GetEntityY (sprite_array [loop].entity) < WaterLevel) Or (sprite_array [loop].alpha < 0.01)
					
					' Destroy the entity...
					
					SGD.DestroyEntity sprite_array [loop].entity
					
					' Destroy the individual ExplosionSprite...
					
					sprite_array [loop].ReduceCount () ' Hmmm...
					sprite_array [loop] = Null
					
				EndIf
			
			Else
			
				' Doesn't exist so must have been destroyed above in sprite_array [loop] = Null...
				
				destroyed_count = destroyed_count + 1

			EndIf
			
		Next
		
		' Trigger sounds...
		
		If SOUNDS_ON

			For Local loop:Int = 0 Until sprite_array.Length

				' Falling particles sound attempt...
				
				If sprite_array [loop].heading_up And sprite_array [loop].ys < 0.0 And Rnd (1.0) > 0.99993 ' Yeesh... fine tuning
					Local stream:Int = SGD.CueSound (Sound_Fall [Rand (0, 1)])
					SGD.SetAudioVolume stream, 0.01
					SGD.SetAudioPitchScale stream, 1.0 + Util.RndF (-0.1, 0.1)
					SGD.SetAudioLooping stream, False
					SGD.SetAudioPaused stream, False
				EndIf

			Next

		EndIf
		
		' If count of destroyed entries is full array, remove explosion from list; delete list if empty...
		
		If destroyed_count = sprite_array.Length
			ListRemove ExplosionList, Self
			If CountList (ExplosionList) < 1 Then ExplosionList = Null
		EndIf

	End Method
	
	' Update all explosions...
	
	Function Update ()
	
		If Not ExplosionList Then Return

		' For each explosion in list...
		
		For Local e:Explosion = EachIn ExplosionList
		
			' Update its sprites...
			
			e.UpdateSprites
			
		Next
		
	End Function
	
End Type

' Individual sprites in list of explosions...

Type ExplosionSprite

	Global Count:Int
	
	Field entity:Int
	Field power:Float
	Field ys:Double
	Field heading_up:Int = False ' Start direction... trigger falling sounds when the 'up' particles are heading down again!
	
	Field water:Int = False
	Field alpha:Float = 1.0 ' for water = True
	
	Method New (x:Double, y:Double, z:Double, _power:Float)

		ys = Rnd (-0.002, 0.001)
		
		If ys > 0 Then heading_up = True

'		entity = SGD.CreateSprite (Explosion.ExplosionSpriteImage)
		entity = SGD.CopyEntity (Explosion.ExplosionParticle)

		Local r:Int = 1.0
		Local g:Int = 1.0
		Local b:Int = 1.0

		If SGD.GetEntityY (entity) > WaterLevel

			r = Rand (0, 1)
			g = Rand (0, 1)
			b = Rand (0, 1)

			' Convert black to white!
'			If Not r And Not g And Not b Then r = 1; g = 1; b = 1
		
		Else
			water = True
		EndIf
		
		SGD.SetSpriteColor entity, r, g, b, alpha
		
		' Position and point in random direction...
		
		SGD.SetEntityPosition entity, x, y, z
		SGD.TurnEntity entity, Rnd (360.0), Rnd (360.0), Rnd (360.0)
		
		' Create random lights...
		
		If Explosion.Lights
			
			' TODO:
			
			'If Rnd (1.0) > 0.85
			
				Local light:Int = SGD.CreatePointLight ()
				
				SGD.SetEntityParent light, entity
				SGD.SetLightRange light, 10
				SGD.SetLightOuterConeAngle light, 10
				SGD.SetLightColor light, r, g, b, 1

				If Explosion.LightShadows
					SGD.SetLightShadowsEnabled light, True
				EndIf
				
			'EndIf
			
		EndIf

		' Mess up uniformity a little...
		
		power = _power + Rnd (-0.1, 0.05)
		
		Count = Count + 1						' Increase here...
		
	End Method

	Function ReduceCount ()
		Self.Count = Self.Count - 1				' Decrease here! Hmm... ??
	End Function
	
End Type

Type Smoke

	Global SmokeParticle:Int
	Global SmokeList:TList		' List of smoke particles
	
	Field smoke_array:SmokeSprite [] ' For smoke
	Field created_time:Int = MilliSecs ()
	
	' Will be set up in New if not called; this stops first pause though!
	
	Function Preload (image:String = "sgd://misc/light.png")
		SmokeList = CreateList ()
		Local sprite_image:Int = SGD.LoadImage (image)
		SmokeParticle = SGD.CreateSprite (sprite_image)
'		SGD.ScaleEntity SmokeParticle, 10, 10, 10
		''SGD.SetEntityVisible SmokeSpriteImage, False
		'SGD.Draw2DImage SmokeSpriteImage, 0, 0, 0
'		SGD.Clear2D
	End Function
	
	Method New (x:Double, y:Double, z:Double, power:Float = 0.95, count:Int = 500)

		If Not SmokeList Then SmokeList = CreateList ()
		If Not SmokeParticle Then Preload ()
		
		' Resize array...
		
		smoke_array = New SmokeSprite [count]
		
		' Assign each sprite in the array...
		
		For Local c:Int = 0 Until count
			smoke_array [c] = New SmokeSprite (x, y, z, power)
			'smoke_array [c].mass = Rnd (0.1, 0.5)
		Next

		' Add current explosion to list of ongoing explosions...
		
		SmokeList.AddLast Self
		
	End Method
	
	' Update sprites in this explosion...
	
	Method UpdateSprites ()
	
		Local destroyed_count:Int = 0

		For Local loop:Int = 0 Until smoke_array.Length
			
			If smoke_array [loop]
			
				smoke_array [loop].ys = smoke_array [loop].ys - Gravity * smoke_array [loop].mass
				
				SGD.MoveEntity smoke_array [loop].entity, 0, 0, smoke_array [loop].power * 0.333
				SGD.TranslateEntity smoke_array [loop].entity, smoke_array [loop].mx, smoke_array [loop].ys, smoke_array [loop].mz
				
				Local Scale:Double = Rnd (1.001, 1.0125)
				SGD.ScaleEntity smoke_array [loop].entity, Scale, Scale, 1
		
				' Fade out if in existence > x seconds...
				
				If MilliSecs () - created_time > 2350

					smoke_array [loop].alpha = Util.DiminishByPercentage (smoke_array [loop].alpha, 98.0)

					SGD.SetSpriteColor smoke_array [loop].entity, 0.0, 0.0, 0.0, smoke_array [loop].alpha
					
					If smoke_array [loop].alpha < 0.005
						
						' Destroy the entity...
						
						SGD.DestroyEntity smoke_array [loop].entity
						
						' Destroy the individual ExplosionSprite...
						
						smoke_array [loop].ReduceCount () ' Hmmm...
						smoke_array [loop] = Null
						
					EndIf

				EndIf
			
			Else
			
				' Doesn't exist so must have been destroyed above in sprite_array [loop] = Null...
				
				destroyed_count = destroyed_count + 1

			EndIf
			
		Next

		' If count of destroyed entries is full array, remove explosion from list; delete list if empty...
		
		If destroyed_count = smoke_array.Length
			ListRemove SmokeList, Self
			If CountList (SmokeList) < 1 Then SmokeList = Null
		EndIf
		
	End Method
	
	' Update all explosions...
	
	Function Update ()
	
		If Not SmokeList Then Return

		' For each explosion in list...
		
		For Local s:Smoke = EachIn SmokeList
		
			' Update its sprites...
			
			s.UpdateSprites
			
		Next
		
	End Function
	
End Type

Type SmokeSprite

	Global Count:Int
	
	Field entity:Int
	Field ys:Double
	Field alpha:Float = 1.0
	Field mx:Float = Rnd (-0.1, 0.1)
	Field my:Float = Rnd (0.05)
	Field mz:Float = Rnd (-0.1, 0.1)
	Field mass:Float = Rnd (0.1, 0.5)
	Field power:Float

	Field water:Int = False
	
	Method New (x:Double, y:Double, z:Double, _power:Float)

		ys = Rnd (-0.002, -0.001)
		
'		entity = SGD.CreateSprite (Smoke.SmokeSpriteImage)
		entity = SGD.CopyEntity (Smoke.SmokeParticle)

'		Local rgb:Int = Rnd (0, 0.25)

		If y - WaterLevel < 0.0
			water = True
			SGD.SetSpriteColor entity, 1.0, 1.0, 1.0, alpha
		Else
			SGD.SetSpriteColor entity, 0.0, 0.0, 0.0, alpha
		EndIf
		
		' Position and point in random direction...
		
		SGD.SetEntityPosition entity, x, y, z
		SGD.TurnEntity entity, Rnd (360.0), Rnd (360.0), Rnd (360.0)
		'SGD.MoveEntity entity, Rnd (-0.2, 0.2), Rnd (0, 0.1), Rnd (-0.2, 0.2)

		power = _power + Rnd (-0.1, 0.05)
		
		Count = Count + 1						' Increase here...

	End Method

	Function ReduceCount ()
		Self.Count = Self.Count - 1				' Decrease here! Hmm... ??
	End Function
	
End Type

Type EntityMarker

	Global MarkerList:TList
	
	Field camera:Int
	
	Field x:Double
	Field y:Double
	Field z:Double
	
	Field created:Int
	Field timeout:Int
	
	Field msg:String
	
	' Pass in entity for position:
	
	Function Create:EntityMarker (_camera:Int, _entity:Int, _msg:String, _timeout:Int = 3000)
	
		If Not MarkerList Then MarkerList = CreateList ()
		
		Local tm:EntityMarker = New EntityMarker

		tm.msg = "<-- " + _msg
		tm.camera = _camera

		tm.x = SGD.GetEntityX (_entity)
		tm.y = SGD.GetEntityY (_entity)
		tm.z = SGD.GetEntityZ (_entity)
		
		tm.created = MilliSecs ()
		tm.timeout = _timeout
		
		ListAddLast EntityMarker.MarkerList, tm
		
		Return tm
		
	End Function

	' Pass in x, y, z for position:
	
	Function Create:EntityMarker (_camera:Int, _x:Double, _y:Double, _z:Double, _msg:String, _timeout:Int = 3000)
	
		If Not MarkerList Then MarkerList = CreateList ()
		
		Local tm:EntityMarker = New EntityMarker

		tm.msg = "<-- " + _msg
		tm.camera = _camera

		tm.x = _x
		tm.y = _y
		tm.z = _z
		
		tm.created = MilliSecs ()
		tm.timeout = _timeout
		
		ListAddLast EntityMarker.MarkerList, tm
		
		Return tm
		
	End Function
	
	Method Update ()
	
		If SGD.CameraProject (camera, x, y, z)

'			SGD.Draw2DText msg, SGD.ProjectedX (), SGD.ProjectedY ()
			
			Local alpha:Float = Max (0.0, 1.0 - (MilliSecs () - created) / Float (timeout))

			SGD.Set2DTextColor 0.0, 0.0, 0.0, 0.9 * alpha
			SGD.Draw2DText msg, SGD.GetProjectedX () + 1, SGD.GetProjectedY () + 1
			SGD.Set2DTextColor 1.0, 1.0, 1.0, alpha
			SGD.Draw2DText msg, SGD.GetProjectedX (), SGD.GetProjectedY ()
			
		EndIf
		
	End Method
	
	Function UpdateAll ()
	
		If Not MarkerList Then Return
		
		For Local em:EntityMarker = EachIn EntityMarker.MarkerList
			
			em.Update

			If MilliSecs () - em.created > em.timeout
				ListRemove EntityMarker.MarkerList, em
				Continue
			EndIf
			
		Next
		
	End Function
	
End Type

Type DelayedExplosionSound

	Const SPEED_OF_SOUND:Float = 343.0 ' 343 m/s... depending.
	
	Field sound:Int
	
	Field x:Double
	Field y:Double
	Field z:Double
	
	Field creation_time:Int
	Field delay_time:Int
	
	Global SoundList:TList

	Method New (_x:Double, _y:Double, _z:Double)

		If Not SoundList Then SoundList = CreateList ()
		
		x = _x
		y = _y
		z = _z
		
		creation_time = MilliSecs ()
		delay_time = 1000.0 * Util.Distance (SGD.GetEntityX (Camera), SGD.GetEntityY (Camera), SGD.GetEntityZ (Camera), x, y, z) / SPEED_OF_SOUND
		
		ListAddLast SoundList, Self
		
	End Method
	
	Function Update ()

		If Not SOUNDS_ON Then Return
		
		If Not SoundList Then Return
		
		Local camera_x:Double = SGD.GetEntityX (Camera)
		Local camera_y:Double = SGD.GetEntityY (Camera)
		Local camera_z:Double = SGD.GetEntityZ (Camera)

		For Local ds:DelayedExplosionSound = EachIn SoundList

			If MilliSecs () > (ds.creation_time + ds.delay_time)

				Local collider:Int = SGD.LinePick (camera_x, camera_y, camera_z, ds.x, ds.y, ds.z, 0.05, -1)

				Local dist:Double = Util.Distance (camera_x, camera_y, camera_z, ds.x, ds.y, ds.z)
				Local max_dist:Double = Min (CameraRange, 750.0) ' Use 750 as max distance here
				Local dist_scaler:Double = dist / max_dist
				Local vol_scaled:Float = Max (0.0, 1.0 - dist_scaler)
				
				Local volume:Float
				Local pitch_scale:Float = 1.0

				If collider = LandCollider
				
					' Land detected before bullet -- bullet behind land, play muffled sample...
					
					ds.sound = Sound_Boom [0]
					volume = vol_scaled * 0.3

					EntityMarker.Create Camera, ds.x, ds.y, ds.z, "Sound muffled by land!"
					
				Else

					Local selection:Int = Rand (1, 6)

					ds.sound = Sound_Boom [selection]
					volume = vol_scaled
					pitch_scale = 1.0 + Util.RndF (-0.3, 0.3)

'					EntityMarker.Create Camera, ds.x, ds.y, ds.z, "Sound not hidden by land!"

				EndIf

				Local stream:Int = SGD.CueSound (ds.sound)

				SGD.SetAudioVolume stream, volume
				SGD.SetAudioPitchScale stream, pitch_scale
				
				SGD.SetAudioLooping stream, False
				SGD.SetAudioPaused stream, False
				
				ListRemove SoundList, ds
				
			EndIf
			
		Next
		
	End Function
	
End Type
