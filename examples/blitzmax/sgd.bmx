' BlitzMax wrapper for LibSGD
'
' Auto-generated : 2026-11-03 17:05:02.957628

Type SGD
	
	'Enum Key
	Const KEY_SPACE:Int = 32
	Const KEY_APOSTROPHE:Int = 39
	Const KEY_COMMA:Int = 44
	Const KEY_MINUS:Int = 45
	Const KEY_PERIOD:Int = 46
	Const KEY_SLASH:Int = 47
	Const KEY_0:Int = 48
	Const KEY_1:Int = 49
	Const KEY_2:Int = 50
	Const KEY_3:Int = 51
	Const KEY_4:Int = 52
	Const KEY_5:Int = 53
	Const KEY_6:Int = 54
	Const KEY_7:Int = 55
	Const KEY_8:Int = 56
	Const KEY_9:Int = 57
	Const KEY_SEMICOLON:Int = 59
	Const KEY_EQUAL:Int = 61
	Const KEY_A:Int = 65
	Const KEY_B:Int = 66
	Const KEY_C:Int = 67
	Const KEY_D:Int = 68
	Const KEY_E:Int = 69
	Const KEY_F:Int = 70
	Const KEY_G:Int = 71
	Const KEY_H:Int = 72
	Const KEY_I:Int = 73
	Const KEY_J:Int = 74
	Const KEY_K:Int = 75
	Const KEY_L:Int = 76
	Const KEY_M:Int = 77
	Const KEY_N:Int = 78
	Const KEY_O:Int = 79
	Const KEY_P:Int = 80
	Const KEY_Q:Int = 81
	Const KEY_R:Int = 82
	Const KEY_S:Int = 83
	Const KEY_T:Int = 84
	Const KEY_U:Int = 85
	Const KEY_V:Int = 86
	Const KEY_W:Int = 87
	Const KEY_X:Int = 88
	Const KEY_Y:Int = 89
	Const KEY_Z:Int = 90
	Const KEY_LEFT_BRACKET:Int = 91
	Const KEY_BACKSLASH:Int = 92
	Const KEY_RIGHT_BRACKET:Int = 93
	Const KEY_GRAVE_ACCENT:Int = 96
	Const KEY_WORLD_1:Int = 161
	Const KEY_WORLD_2:Int = 162
	Const KEY_ESCAPE:Int = 256
	Const KEY_ENTER:Int = 257
	Const KEY_TAB:Int = 258
	Const KEY_BACKSPACE:Int = 259
	Const KEY_INSERT:Int = 260
	Const KEY_DELETE:Int = 261
	Const KEY_RIGHT:Int = 262
	Const KEY_LEFT:Int = 263
	Const KEY_DOWN:Int = 264
	Const KEY_UP:Int = 265
	Const KEY_PAGE_UP:Int = 266
	Const KEY_PAGE_DOWN:Int = 267
	Const KEY_HOME:Int = 268
	Const KEY_END:Int = 269
	Const KEY_CAPS_LOCK:Int = 280
	Const KEY_SCROLL_LOCK:Int = 281
	Const KEY_NUM_LOCK:Int = 282
	Const KEY_PRINT_SCREEN:Int = 283
	Const KEY_PAUSE:Int = 284
	Const KEY_F1:Int = 290
	Const KEY_F2:Int = 291
	Const KEY_F3:Int = 292
	Const KEY_F4:Int = 293
	Const KEY_F5:Int = 294
	Const KEY_F6:Int = 295
	Const KEY_F7:Int = 296
	Const KEY_F8:Int = 297
	Const KEY_F9:Int = 298
	Const KEY_F10:Int = 299
	Const KEY_F11:Int = 300
	Const KEY_F12:Int = 301
	Const KEY_F13:Int = 302
	Const KEY_F14:Int = 303
	Const KEY_F15:Int = 304
	Const KEY_F16:Int = 305
	Const KEY_F17:Int = 306
	Const KEY_F18:Int = 307
	Const KEY_F19:Int = 308
	Const KEY_F20:Int = 309
	Const KEY_F21:Int = 310
	Const KEY_F22:Int = 311
	Const KEY_F23:Int = 312
	Const KEY_F24:Int = 313
	Const KEY_F25:Int = 314
	Const KEY_KP_0:Int = 320
	Const KEY_KP_1:Int = 321
	Const KEY_KP_2:Int = 322
	Const KEY_KP_3:Int = 323
	Const KEY_KP_4:Int = 324
	Const KEY_KP_5:Int = 325
	Const KEY_KP_6:Int = 326
	Const KEY_KP_7:Int = 327
	Const KEY_KP_8:Int = 328
	Const KEY_KP_9:Int = 329
	Const KEY_KP_DECIMAL:Int = 330
	Const KEY_KP_DIVIDE:Int = 331
	Const KEY_KP_MULTIPLY:Int = 332
	Const KEY_KP_SUBTRACT:Int = 333
	Const KEY_KP_ADD:Int = 334
	Const KEY_KP_ENTER:Int = 335
	Const KEY_KP_EQUAL:Int = 336
	Const KEY_LEFT_SHIFT:Int = 340
	Const KEY_LEFT_CONTROL:Int = 341
	Const KEY_LEFT_ALT:Int = 342
	Const KEY_LEFT_SUPER:Int = 343
	Const KEY_RIGHT_SHIFT:Int = 344
	Const KEY_RIGHT_CONTROL:Int = 345
	Const KEY_RIGHT_ALT:Int = 346
	Const KEY_RIGHT_SUPER:Int = 347
	Const KEY_MENU:Int = 348
	Const KEY_LAST:Int = 348
	'Enum KeyModifiers
	Const KEY_MODIFIERS_SHIFT:Int = $0001
	Const KEY_MODIFIERS_CONTROL:Int = $0002
	Const KEY_MODIFIERS_ALT:Int = $0004
	Const KEY_MODIFIERS_SUPER:Int = $0008
	Const KEY_MODIFIERS_CAPS_LOCK:Int = $0010
	Const KEY_MODIFIERS_NUM_LOCK:Int = $0020
	'Enum MouseButton
	Const MOUSE_BUTTON_LEFT:Int = 0
	Const MOUSE_BUTTON_RIGHT:Int = 1
	Const MOUSE_BUTTON_MIDDLE:Int = 2
	'Enum GamepadButton
	Const GAMEPAD_BUTTON_A:Int = 0
	Const GAMEPAD_BUTTON_B:Int = 1
	Const GAMEPAD_BUTTON_X:Int = 2
	Const GAMEPAD_BUTTON_Y:Int = 3
	Const GAMEPAD_BUTTON_LEFT_BUMPER:Int = 4
	Const GAMEPAD_BUTTON_RIGHT_BUMPER:Int = 5
	Const GAMEPAD_BUTTON_BACK:Int = 6
	Const GAMEPAD_BUTTON_START:Int = 7
	Const GAMEPAD_BUTTON_GUIDE:Int = 8
	Const GAMEPAD_BUTTON_LEFT_THUMB:Int = 9
	Const GAMEPAD_BUTTON_RIGHT_THUMB:Int = 10
	Const GAMEPAD_BUTTON_DPAD_UP:Int = 11
	Const GAMEPAD_BUTTON_DPAD_RIGHT:Int = 12
	Const GAMEPAD_BUTTON_DPAD_DOWN:Int = 13
	Const GAMEPAD_BUTTON_DPAD_LEFT:Int = 14
	Const GAMEPAD_BUTTON_CROSS:Int = 0
	Const GAMEPAD_BUTTON_CIRCLE:Int = 1
	Const GAMEPAD_BUTTON_SQUARE:Int = 2
	Const GAMEPAD_BUTTON_TRIANGLE:Int = 3
	'Enum GamepadAxis
	Const GAMEPAD_AXIS_LEFT_X:Int = 0
	Const GAMEPAD_AXIS_LEFT_Y:Int = 1
	Const GAMEPAD_AXIS_RIGHT_X:Int = 2
	Const GAMEPAD_AXIS_RIGHT_Y:Int = 3
	Const GAMEPAD_AXIS_LEFT_TRIGGER:Int = 4
	Const GAMEPAD_AXIS_RIGHT_TRIGGER:Int = 5
	'Enum EventMask
	Const EVENT_MASK_CLOSE_CLICKED:Int = $01
	Const EVENT_MASK_SIZE_CHANGED:Int = $02
	Const EVENT_MASK_LOST_FOCUS:Int = $04
	Const EVENT_MASK_GOT_FOCUS:Int = $08
	Const EVENT_MASK_SUSPENDED:Int = $10
	Const EVENT_MASK_RESUMED:Int = $20
	'Enum WindowState
	Const WINDOW_STATE_CLOSED:Int = 0
	Const WINDOW_STATE_MINIMIZED:Int = 1
	Const WINDOW_STATE_NORMAL:Int = 2
	Const WINDOW_STATE_MAXIMIZED:Int = 3
	Const WINDOW_STATE_FULLSCREEN:Int = 4
	'Enum WindowFlags
	Const WINDOW_FLAGS_NONE:Int = $00
	Const WINDOW_FLAGS_FULLSCREEN:Int = $01
	Const WINDOW_FLAGS_RESIZABLE:Int = $02
	Const WINDOW_FLAGS_CENTERED:Int = $04
	'Enum MouseCursorMode
	Const MOUSE_CURSOR_MODE_NORMAL:Int = 1
	Const MOUSE_CURSOR_MODE_HIDDEN:Int = 2
	Const MOUSE_CURSOR_MODE_DISABLED:Int = 3
	Const MOUSE_CURSOR_MODE_CAPTURED:Int = 4
	'Enum TextureType
	Const TEXTURE_TYPE_2D:Int = 1
	Const TEXTURE_TYPE_CUBE:Int = 2
	Const TEXTURE_TYPE_ARRAY:Int = 3
	'Enum TextureFormat
	Const TEXTURE_FORMAT_ANY:Int = 0
	Const TEXTURE_FORMAT_R8:Int = 1
	Const TEXTURE_FORMAT_RG8:Int = 2
	Const TEXTURE_FORMAT_RGBA8:Int = 3
	Const TEXTURE_FORMAT_SRGBA8:Int = 4
	Const TEXTURE_FORMAT_R8S:Int = 5
	Const TEXTURE_FORMAT_RG8S:Int = 6
	Const TEXTURE_FORMAT_RGBA8S:Int = 7
	Const TEXTURE_FORMAT_R16F:Int = 8
	Const TEXTURE_FORMAT_RG16F:Int = 9
	Const TEXTURE_FORMAT_RGBA16F:Int = 10
	'Enum TextureFlags
	Const TEXTURE_FLAGS_NONE:Int = $0
	Const TEXTURE_FLAGS_CLAMP_U:Int = $01
	Const TEXTURE_FLAGS_CLAMP_V:Int = $02
	Const TEXTURE_FLAGS_CLAMP_W:Int = $04
	Const TEXTURE_FLAGS_FILTER:Int = $08
	Const TEXTURE_FLAGS_MIPMAP:Int = $10
	Const TEXTURE_FLAGS_DEFAULT:Int = $18
	Const TEXTURE_FLAGS_IMAGE:Int = $01f
	'Enum BlendMode
	Const BLEND_MODE_OPAQUE:Int = 1
	Const BLEND_MODE_ALPHA_MASK:Int = 2
	Const BLEND_MODE_ALPHA_BLEND:Int = 3
	'Enum DepthFunc
	Const DEPTH_FUNC_NEVER:Int = 1
	Const DEPTH_FUNC_LESS:Int = 2
	Const DEPTH_FUNC_EQUAL:Int = 3
	Const DEPTH_FUNC_LESS_EQUAL:Int = 4
	Const DEPTH_FUNC_GREATER:Int = 5
	Const DEPTH_FUNC_NOT_EQUAL:Int = 6
	Const DEPTH_FUNC_GREATER_EQUAL:Int = 7
	Const DEPTH_FUNC_ALWAYS:Int = 8
	'Enum CullMode
	Const CULL_MODE_NONE:Int = 1
	Const CULL_MODE_FRONT:Int = 2
	Const CULL_MODE_BACK:Int = 3
	'Enum MeshFlags
	Const MESH_FLAGS_NONE:Int = 0
	Const MESH_FLAGS_TANGENTS_ENABLED:Int = 1
	Const MESH_FLAGS_BLENDED_SURFACES:Int = 2
	'Enum ImageViewMode
	Const IMAGE_VIEW_MODE_FIXED:Int = 1
	Const IMAGE_VIEW_MODE_FREE:Int = 2
	Const IMAGE_VIEW_MODE_UPRIGHT:Int = 3
	'Enum CameraType
	Const CAMERA_TYPE_PERSPECTIVE:Int = 1
	Const CAMERA_TYPE_ORTHOGRAPHIC:Int = 2
	'Enum LightType
	Const LIGHT_TYPE_DIRECTIONAL:Int = 1
	Const LIGHT_TYPE_POINT:Int = 2
	Const LIGHT_TYPE_SPOT:Int = 3
	'Enum AnimationMode
	Const ANIMATION_MODE_ONE_SHOT:Int = 1
	Const ANIMATION_MODE_LOOP:Int = 2
	Const ANIMATION_MODE_PING_PONG:Int = 3
	'Enum CollisionResponse
	Const COLLISION_RESPONSE_NONE:Int = 0
	Const COLLISION_RESPONSE_STOP:Int = 1
	Const COLLISION_RESPONSE_SLIDE:Int = 2
	Const COLLISION_RESPONSE_SLIDEXZ:Int = 3
	
	Global Init() "os"
	Global GetVersion_native:Byte Ptr() "os"
	Function GetVersion:String()
		Return String.FromUTF8String(GetVersion_native())
	End Function
	Global Terminate() "os"
	Global SetConfigVar_native(name:Byte Ptr, value:Byte Ptr) "os"
	Function SetConfigVar(name:String, value:String)
		SetConfigVar_native(name.ToUTF8String(), value.ToUTF8String())
	End Function
	Global GetConfigVar_native:Byte Ptr(name:Byte Ptr) "os"
	Function GetConfigVar:String(name:String)
		Return String.FromUTF8String(GetConfigVar_native(name.ToUTF8String()))
	End Function
	Global Error_native(error:Byte Ptr) "os"
	Function Error(error:String)
		Error_native(error.ToUTF8String())
	End Function
	Global Alert_native(message:Byte Ptr) "os"
	Function Alert(message:String)
		Alert_native(message.ToUTF8String())
	End Function
	Global Log_native(line:Byte Ptr) "os"
	Function Log(line:String)
		Log_native(line.ToUTF8String())
	End Function
	Global GetDesktopWidth:Int() "os"
	Global GetDesktopHeight:Int() "os"
	Global PollEvents:Int() "os"
	Global ReleaseHandle(handle:Int) "os"
	Global ReleaseAllHandles() "os"
	Global DebugMemory() "os"
	Global CreateWindow_native(width:Int, height:Int, title:Byte Ptr, flags:Int) "os"
	Function CreateWindow(width:Int, height:Int, title:String, flags:Int)
		CreateWindow_native(width, height, title.ToUTF8String(), flags)
	End Function
	Global DestroyWindow() "os"
	Global SetWindowPosition(x:Int, y:Int) "os"
	Global GetWindowX:Int() "os"
	Global GetWindowY:Int() "os"
	Global SetWindowSize(width:Int, height:Int) "os"
	Global GetWindowWidth:Int() "os"
	Global GetWindowHeight:Int() "os"
	Global SetWindowTitle_native(title:Byte Ptr) "os"
	Function SetWindowTitle(title:String)
		SetWindowTitle_native(title.ToUTF8String())
	End Function
	Global GetWindowTitle_native:Byte Ptr() "os"
	Function GetWindowTitle:String()
		Return String.FromUTF8String(GetWindowTitle_native())
	End Function
	Global SetFullscreenMode(width:Int, height:Int, hertz:Int) "os"
	Global SetWindowState(state:Int) "os"
	Global GetWindowState:Int() "os"
	Global IsKeyDown:Int(key:Int) "os"
	Global IsKeyHit:Int(key:Int) "os"
	Global GetChar:Int() "os"
	Global FlushChars() "os"
	Global GetMouseX:Float() "os"
	Global GetMouseY:Float() "os"
	Global GetMouseZ:Float() "os"
	Global GetMouseVX:Float() "os"
	Global GetMouseVY:Float() "os"
	Global GetMouseVZ:Float() "os"
	Global SetMouseZ(z:Float) "os"
	Global SetMouseCursorMode(cursorMode:Int) "os"
	Global IsMouseButtonDown:Int(button:Int) "os"
	Global IsMouseButtonHit:Int(button:Int) "os"
	Global IsGamepadConnected:Int(gamepad:Int) "os"
	Global IsGamepadButtonDown:Int(gamepad:Int, button:Int) "os"
	Global IsGamepadButtonHit:Int(gamepad:Int, button:Int) "os"
	Global GetGamepadAxis:Float(gamepad:Int, axis:Int) "os"
	Global Load2DTexture_native:Int(path:Byte Ptr, format:Int, flags:Int) "os"
	Function Load2DTexture:Int(path:String, format:Int, flags:Int)
		Return Load2DTexture_native(path.ToUTF8String(), format, flags)
	End Function
	Global LoadCubeTexture_native:Int(path:Byte Ptr, format:Int, flags:Int) "os"
	Function LoadCubeTexture:Int(path:String, format:Int, flags:Int)
		Return LoadCubeTexture_native(path.ToUTF8String(), format, flags)
	End Function
	Global LoadArrayTexture_native:Int(path:Byte Ptr, format:Int, flags:Int) "os"
	Function LoadArrayTexture:Int(path:String, format:Int, flags:Int)
		Return LoadArrayTexture_native(path.ToUTF8String(), format, flags)
	End Function
	Global Create2DTexture:Int(width:Int, height:Int, format:Int, flags:Int) "os"
	Global CreateCubeTexture:Int(size:Int, format:Int, flags:Int) "os"
	Global CreateArrayTexture:Int(width:Int, height:Int, depth:Int, format:Int, flags:Int) "os"
	Global GetTextureType:Int(texture:Int) "os"
	Global GetTextureWidth:Int(texture:Int) "os"
	Global GetTextureHeight:Int(texture:Int) "os"
	Global GetTextureDepth:Int(texture:Int) "os"
	Global GetTextureFormat:Int(texture:Int) "os"
	Global GetTextureFlags:Int(texture:Int) "os"
	Global SetTexelSRGBA(texture:Int, x:Int, y:Int, rgba:Int) "os"
	Global GetTexelSRGBA:Int(texture:Int, x:Int, y:Int) "os"
	Global LoadPBRMaterial_native:Int(path:Byte Ptr) "os"
	Function LoadPBRMaterial:Int(path:String)
		Return LoadPBRMaterial_native(path.ToUTF8String())
	End Function
	Global CreatePBRMaterial:Int() "os"
	Global LoadPrelitMaterial_native:Int(path:Byte Ptr) "os"
	Function LoadPrelitMaterial:Int(path:String)
		Return LoadPrelitMaterial_native(path.ToUTF8String())
	End Function
	Global CreatePrelitMaterial:Int() "os"
	Global SetMaterialBlendMode(material:Int, blendMode:Int) "os"
	Global SetMaterialDepthFunc(material:Int, depthFunc:Int) "os"
	Global SetMaterialCullMode(material:Int, cullMode:Int) "os"
	Global SetMaterialTexture_native(material:Int, parameter:Byte Ptr, texture:Int) "os"
	Function SetMaterialTexture(material:Int, parameter:String, texture:Int)
		SetMaterialTexture_native(material, parameter.ToUTF8String(), texture)
	End Function
	Global SetMaterialColor_native(material:Int, parameter:Byte Ptr, red:Float, green:Float, blue:Float, alpha:Float) "os"
	Function SetMaterialColor(material:Int, parameter:String, red:Float, green:Float, blue:Float, alpha:Float)
		SetMaterialColor_native(material, parameter.ToUTF8String(), red, green, blue, alpha)
	End Function
	Global SetMaterialFloat_native(material:Int, parameter:Byte Ptr, value:Float) "os"
	Function SetMaterialFloat(material:Int, parameter:String, value:Float)
		SetMaterialFloat_native(material, parameter.ToUTF8String(), value)
	End Function
	Global LoadMesh_native:Int(path:Byte Ptr) "os"
	Function LoadMesh:Int(path:String)
		Return LoadMesh_native(path.ToUTF8String())
	End Function
	Global CopyMesh:Int(mesh:Int) "os"
	Global CreateBoxMesh:Int(minX:Float, minY:Float, minZ:Float, maxX:Float, maxY:Float, maxZ:Float, material:Int) "os"
	Global CreateSphereMesh:Int(radius:Float, xSegs:Int, ySegs:Int, material:Int) "os"
	Global CreateCylinderMesh:Int(height:Float, radius:Float, segs:Int, material:Int) "os"
	Global CreateConeMesh:Int(height:Float, radius:Float, segs:Int, material:Int) "os"
	Global CreateTorusMesh:Int(outerRadius:Float, innerRadius:Float, outerSegs:Int, innerSegs:Int, material:Int) "os"
	Global SetMeshShadowsEnabled(mesh:Int, enabled:Int) "os"
	Global IsMeshShadowsEnabled:Int(mesh:Int) "os"
	Global UpdateMeshNormals(mesh:Int) "os"
	Global UpdateMeshTangents(mesh:Int) "os"
	Global FitMesh(mesh:Int, minX:Float, minY:Float, minZ:Float, maxX:Float, maxY:Float, maxZ:Float, uniform:Int) "os"
	Global TransformMesh(mesh:Int, tx:Float, ty:Float, tz:Float, rx:Float, ry:Float, rz:Float, sx:Float, sy:Float, sz:Float) "os"
	Global TransformTexCoords(mesh:Int, scaleX:Float, scaleY:Float, offsetX:Float, offsetY:Float) "os"
	Global FlipMesh(mesh:Int) "os"
	Global GetMeshBoundsMinX:Float(mesh:Int) "os"
	Global GetMeshBoundsMinY:Float(mesh:Int) "os"
	Global GetMeshBoundsMinZ:Float(mesh:Int) "os"
	Global GetMeshBoundsMaxX:Float(mesh:Int) "os"
	Global GetMeshBoundsMaxY:Float(mesh:Int) "os"
	Global GetMeshBoundsMaxZ:Float(mesh:Int) "os"
	Global CreateMesh:Int(vertexCount:Int, flags:Int) "os"
	Global ResizeVertices(mesh:Int, count:Int) "os"
	Global GetVertexCount:Int(mesh:Int) "os"
	Global AddVertex:Int(mesh:Int, x:Float, y:Float, z:Float, nx:Float, ny:Float, nz:Float, s:Float, t:Float) "os"
	Global SetVertex(mesh:Int, vertex:Int, x:Float, y:Float, z:Float, nx:Float, ny:Float, nz:Float, s:Float, t:Float) "os"
	Global SetVertexPosition(mesh:Int, vertex:Int, x:Float, y:Float, z:Float) "os"
	Global SetVertexNormal(mesh:Int, vertex:Int, nx:Float, ny:Float, nz:Float) "os"
	Global SetVertexTangent(mesh:Int, vertex:Int, tx:Float, ty:Float, tz:Float, tw:Float) "os"
	Global SetVertexColor(mesh:Int, vertex:Int, r:Float, g:Float, b:Float, a:Float) "os"
	Global SetVertexTexCoord0(mesh:Int, vertex:Int, u0:Float, v0:Float) "os"
	Global GetVertexX:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexY:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexZ:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexNX:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexNY:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexNZ:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexTX:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexTY:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexTZ:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexTW:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexRed:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexGreen:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexBlue:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexAlpha:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexU0:Float(mesh:Int, vertex:Int) "os"
	Global GetVertexV0:Float(mesh:Int, vertex:Int) "os"
	Global CreateSurface:Int(mesh:Int, material:Int, triangleCount:Int) "os"
	Global GetSurfaceCount:Int(mesh:Int) "os"
	Global GetSurface:Int(mesh:Int, surface:Int) "os"
	Global GetMaterial:Int(surface:Int) "os"
	Global ResizeTriangles(surface:Int, count:Int) "os"
	Global GetTriangleCount:Int(surface:Int) "os"
	Global AddTriangle:Int(surface:Int, v0:Int, v1:Int, v2:Int) "os"
	Global SetTriangle(surface:Int, triangle:Int, v0:Int, v1:Int, v2:Int) "os"
	Global GetTriangleVertex:Int(surface:Int, triangle:Int, vertex:Int) "os"
	Global LoadFont_native:Int(path:Byte Ptr, height:Float) "os"
	Function LoadFont:Int(path:String, height:Float)
		Return LoadFont_native(path.ToUTF8String(), height)
	End Function
	Global GetTextWidth_native:Float(font:Int, text:Byte Ptr) "os"
	Function GetTextWidth:Float(font:Int, text:String)
		Return GetTextWidth_native(font, text.ToUTF8String())
	End Function
	Global GetFontHeight:Float(font:Int) "os"
	Global LoadImage_native:Int(path:Byte Ptr) "os"
	Function LoadImage:Int(path:String)
		Return LoadImage_native(path.ToUTF8String())
	End Function
	Global LoadArrayImage_native:Int(path:Byte Ptr, frameCount:Int, framesX:Int, framesY:Int, frameSpacing:Int) "os"
	Function LoadArrayImage:Int(path:String, frameCount:Int, framesX:Int, framesY:Int, frameSpacing:Int)
		Return LoadArrayImage_native(path.ToUTF8String(), frameCount, framesX, framesY, frameSpacing)
	End Function
	Global CreateImage:Int(texture:Int) "os"
	Global SetImageViewMode(image:Int, viewMode:Int) "os"
	Global SetImageBlendMode(image:Int, blendMode:Int) "os"
	Global SetImageRect(image:Int, minX:Float, minY:Float, maxX:Float, maxY:Float) "os"
	Global GetImageTexture:Int(image:Int) "os"
	Global Set2DFillColor(red:Float, green:Float, blue:Float, alpha:Float) "os"
	Global Set2DFillMaterial(material:Int) "os"
	Global Set2DFillEnabled(enabled:Int) "os"
	Global Set2DOutlineColor(red:Float, green:Float, blue:Float, alpha:Float) "os"
	Global Set2DOutlineWidth(width:Float) "os"
	Global Set2DOutlineEnabled(enabled:Int) "os"
	Global Set2DLineWidth(width:Float) "os"
	Global Set2DPointSize(size:Float) "os"
	Global Set2DFont(font:Int) "os"
	Global Set2DTextColor(red:Float, green:Float, blue:Float, alpha:Float) "os"
	Global Get2DTextWidth_native:Float(text:Byte Ptr) "os"
	Function Get2DTextWidth:Float(text:String)
		Return Get2DTextWidth_native(text.ToUTF8String())
	End Function
	Global Get2DFontHeight:Float() "os"
	Global Clear2D() "os"
	Global Push2DLayer() "os"
	Global Pop2DLayer() "os"
	Global Draw2DPoint(x0:Float, y0:Float) "os"
	Global Draw2DLine(x0:Float, y0:Float, x1:Float, y1:Float) "os"
	Global Draw2DRect(minX:Float, minY:Float, maxX:Float, maxY:Float) "os"
	Global Draw2DImage(image:Int, x:Float, y:Float, frame:Float) "os"
	Global Draw2DOval(minX:Float, minY:Float, maxX:Float, maxY:Float) "os"
	Global Draw2DText_native(text:Byte Ptr, x:Float, y:Float) "os"
	Function Draw2DText(text:String, x:Float, y:Float)
		Draw2DText_native(text.ToUTF8String(), x, y)
	End Function
	Global ClearScene() "os"
	Global ResetScene(releaseAllHandles:Int) "os"
	Global LoadScene_native(path:Byte Ptr) "os"
	Function LoadScene(path:String)
		LoadScene_native(path.ToUTF8String())
	End Function
	Global SaveScene_native(path:Byte Ptr) "os"
	Function SaveScene(path:String)
		SaveScene_native(path.ToUTF8String())
	End Function
	Global SetAmbientLightColor(red:Float, green:Float, blue:Float, alpha:Float) "os"
	Global SetClearColor(red:Float, green:Float, blue:Float, alpha:Float) "os"
	Global SetClearDepth(depth:Float) "os"
	Global SetEnvTexture(texture:Int) "os"
	Global UpdateShadowMappingConfig() "os"
	Global RenderScene() "os"
	Global Present() "os"
	Global GetFPS:Float() "os"
	Global GetRPS:Float() "os"
	Global SetEntityEnabled(entity:Int, enabled:Int) "os"
	Global IsEntityEnabled:Int(entity:Int) "os"
	Global SetEntityVisible(entity:Int, visible:Int) "os"
	Global IsEntityVisible:Int(entity:Int) "os"
	Global DestroyEntity(entity:Int) "os"
	Global ResetEntity(entity:Int) "os"
	Global CopyEntity:Int(entity:Int) "os"
	Global SetEntityName_native(entity:Int, name:Byte Ptr) "os"
	Function SetEntityName(entity:Int, name:String)
		SetEntityName_native(entity, name.ToUTF8String())
	End Function
	Global GetEntityName_native:Byte Ptr(entity:Int) "os"
	Function GetEntityName:String(entity:Int)
		Return String.FromUTF8String(GetEntityName_native(entity))
	End Function
	Global SetEntityParent(entity:Int, parent:Int) "os"
	Global GetEntityParent:Int(entity:Int) "os"
	Global GetEntityChildCount:Int(entity:Int) "os"
	Global GetEntityChild:Int(entity:Int, childIndex:Int) "os"
	Global FindEntityChild_native:Int(entity:Int, childName:Byte Ptr) "os"
	Function FindEntityChild:Int(entity:Int, childName:String)
		Return FindEntityChild_native(entity, childName.ToUTF8String())
	End Function
	Global SetEntityPosition(entity:Int, tx:Double, ty:Double, tz:Double) "os"
	Global SetEntityRotation(entity:Int, rx:Double, ry:Double, rz:Double) "os"
	Global SetEntityScale(entity:Int, sx:Double, sy:Double, sz:Double) "os"
	Global TranslateEntity(entity:Int, tx:Double, ty:Double, tz:Double) "os"
	Global RotateEntity(entity:Int, rx:Double, ry:Double, rz:Double) "os"
	Global ScaleEntity(entity:Int, sx:Double, sy:Double, sz:Double) "os"
	Global MoveEntity(entity:Int, tx:Double, ty:Double, tz:Double) "os"
	Global TurnEntity(entity:Int, rx:Double, ry:Double, rz:Double) "os"
	Global GetEntityX:Double(entity:Int) "os"
	Global GetEntityY:Double(entity:Int) "os"
	Global GetEntityZ:Double(entity:Int) "os"
	Global GetEntityRX:Double(entity:Int) "os"
	Global GetEntityRY:Double(entity:Int) "os"
	Global GetEntityRZ:Double(entity:Int) "os"
	Global GetEntitySX:Double(entity:Int) "os"
	Global GetEntitySY:Double(entity:Int) "os"
	Global GetEntitySZ:Double(entity:Int) "os"
	Global GetEntityIX:Double(entity:Int) "os"
	Global GetEntityIY:Double(entity:Int) "os"
	Global GetEntityIZ:Double(entity:Int) "os"
	Global GetEntityJX:Double(entity:Int) "os"
	Global GetEntityJY:Double(entity:Int) "os"
	Global GetEntityJZ:Double(entity:Int) "os"
	Global GetEntityKX:Double(entity:Int) "os"
	Global GetEntityKY:Double(entity:Int) "os"
	Global GetEntityKZ:Double(entity:Int) "os"
	Global AimEntityAtEntity(entity:Int, target:Int, roll:Float) "os"
	Global AimEntityAtPoint(entity:Int, x:Double, y:Double, z:Double, roll:Float) "os"
	Global TransformPoint(x:Double, y:Double, z:Double, srcEntity:Int, dstEntity:Int) "os"
	Global TransformVector(x:Double, y:Double, z:Double, srcEntity:Int, dstEntity:Int) "os"
	Global TransformNormal(x:Double, y:Double, z:Double, srcEntity:Int, dstEntity:Int) "os"
	Global GetTransformedX:Double() "os"
	Global GetTransformedY:Double() "os"
	Global GetTransformedZ:Double() "os"
	Global CreatePerspectiveCamera:Int() "os"
	Global CreateOrthographicCamera:Int() "os"
	Global GetCameraType:Int(camera:Int) "os"
	Global SetCameraFOV(camera:Int, fovY:Float) "os"
	Global SetCameraNear(camera:Int, near:Float) "os"
	Global SetCameraFar(camera:Int, far:Float) "os"
	Global CameraProject:Int(camera:Int, x:Double, y:Double, z:Double) "os"
	Global GetProjectedX:Float() "os"
	Global GetProjectedY:Float() "os"
	Global CameraUnproject:Int(camera:Int, windowX:Float, windowY:Float, viewZ:Float) "os"
	Global GetUnprojectedX:Double() "os"
	Global GetUnprojectedY:Double() "os"
	Global GetUnprojectedZ:Double() "os"
	Global CreateDirectionalLight:Int() "os"
	Global CreatePointLight:Int() "os"
	Global CreateSpotLight:Int() "os"
	Global GetLightType:Int(light:Int) "os"
	Global SetLightShadowsEnabled(light:Int, enabled:Int) "os"
	Global IsLightShadowsEnabled:Int(light:Int) "os"
	Global SetLightPriority(light:Int, priority:Int) "os"
	Global GetLightPriority:Int(light:Int) "os"
	Global SetLightColor(light:Int, red:Float, green:Float, blue:Float, alpha:Float) "os"
	Global SetLightRange(light:Int, range:Float) "os"
	Global SetLightFalloff(light:Int, falloff:Float) "os"
	Global SetLightInnerConeAngle(light:Int, angle:Float) "os"
	Global SetLightOuterConeAngle(light:Int, angle:Float) "os"
	Global LoadModel_native:Int(path:Byte Ptr) "os"
	Function LoadModel:Int(path:String)
		Return LoadModel_native(path.ToUTF8String())
	End Function
	Global LoadBonedModel_native:Int(path:Byte Ptr, skinned:Int) "os"
	Function LoadBonedModel:Int(path:String, skinned:Int)
		Return LoadBonedModel_native(path.ToUTF8String(), skinned)
	End Function
	Global CreateModel:Int(mesh:Int) "os"
	Global SetModelMesh(model:Int, mesh:Int) "os"
	Global GetModelMesh:Int(model:Int) "os"
	Global SetModelColor(model:Int, red:Float, green:Float, blue:Float, alpha:Float) "os"
	Global AnimateModel(model:Int, animation:Int, time:Float, animationMode:Int, weight:Float) "os"
	Global LoadSkybox_native:Int(path:Byte Ptr, roughness:Float) "os"
	Function LoadSkybox:Int(path:String, roughness:Float)
		Return LoadSkybox_native(path.ToUTF8String(), roughness)
	End Function
	Global CreateSkybox:Int(texture:Int) "os"
	Global SetSkyboxTexture(skybox:Int, texture:Int) "os"
	Global SetSkyboxRoughness(skybox:Int, roughness:Float) "os"
	Global CreateTerrain:Int() "os"
	Global SetTerrainSize(terrain:Int, size:Int) "os"
	Global SetTerrainLODs(terrain:Int, lods:Int) "os"
	Global SetTerrainMaterial(terrain:Int, material:Int) "os"
	Global SetTerrainMaterialSize(terrain:Int, materialSize:Int) "os"
	Global SetTerrainHeightTexture(terrain:Int, texture:Int) "os"
	Global SetTerrainNormalTexture(terrain:Int, texture:Int) "os"
	Global SetTerrainDebugMode(terrain:Int, debugMode:Int) "os"
	Global CreateSprite:Int(image:Int) "os"
	Global SetSpriteImage(sprite:Int, image:Int) "os"
	Global SetSpriteColor(sprite:Int, red:Float, green:Float, blue:Float, alpha:Float) "os"
	Global SetSpriteFrame(sprite:Int, frame:Float) "os"
	Global CreateSphereCollider:Int(entity:Int, colliderType:Int, radius:Float) "os"
	Global CreateEllipsoidCollider:Int(entity:Int, colliderType:Int, radius:Float, height:Float) "os"
	Global CreateMeshCollider:Int(entity:Int, colliderType:Int, mesh:Int) "os"
	Global GetColliderEntity:Int(collider:Int) "os"
	Global GetColliderType:Int(collider:Int) "os"
	Global SetColliderRadius(collider:Int, radius:Float) "os"
	Global SetColliderHeight(collider:Int, height:Float) "os"
	Global EnableCollisions(srcColliderType:Int, dstColliderType:Int, response:Int) "os"
	Global UpdateColliders() "os"
	Global GetCollisionCount:Int(collider:Int) "os"
	Global GetCollisionCollider:Int(collider:Int, index:Int) "os"
	Global GetCollisionX:Double(collider:Int, index:Int) "os"
	Global GetCollisionY:Double(collider:Int, index:Int) "os"
	Global GetCollisionZ:Double(collider:Int, index:Int) "os"
	Global GetCollisionNX:Double(collider:Int, index:Int) "os"
	Global GetCollisionNY:Double(collider:Int, index:Int) "os"
	Global GetCollisionNZ:Double(collider:Int, index:Int) "os"
	Global CameraPick:Int(camera:Int, windowX:Float, windowY:Float, colliderMask:Int) "os"
	Global LinePick:Int(x0:Double, y0:Double, z0:Double, x1:Double, y1:Double, z1:Double, radius:Double, colliderMask:Int) "os"
	Global GetPickedX:Double() "os"
	Global GetPickedY:Double() "os"
	Global GetPickedZ:Double() "os"
	Global GetPickedNX:Double() "os"
	Global GetPickedNY:Double() "os"
	Global GetPickedNZ:Double() "os"
	Global CreateBloomEffect:Int() "os"
	Global SetBloomEffectRadius(effect:Int, radius:Int) "os"
	Global GetBloomEffectRadius:Int(effect:Int) "os"
	Global CreateBlurEffect:Int() "os"
	Global SetBlurEffectRadius(effect:Int, radius:Int) "os"
	Global GetBlurEffectRadius:Int(effect:Int) "os"
	Global CreateFogEffect:Int() "os"
	Global SetFogEffectColor(effect:Int, red:Float, green:Float, blue:Float, alpha:Float) "os"
	Global SetFogEffectRange(effect:Int, near:Float, far:Float) "os"
	Global SetFogEffectPower(effect:Int, power:Float) "os"
	Global CreateMonocolorEffect:Int() "os"
	Global SetMonocolorEffectColor(effect:Int, red:Float, green:Float, blue:Float, alpha:Float) "os"
	Global SetRenderEffectEnabled(effect:Int, enabled:Int) "os"
	Global IsRenderEffectEnabled:Int(effect:Int) "os"
	Global LoadSound_native:Int(path:Byte Ptr) "os"
	Function LoadSound:Int(path:String)
		Return LoadSound_native(path.ToUTF8String())
	End Function
	Global PlaySound:Int(sound:Int) "os"
	Global CueSound:Int(sound:Int) "os"
	Global SetAudioVolume(audio:Int, volume:Float) "os"
	Global SetAudioPan(audio:Int, pan:Float) "os"
	Global SetAudioPitchScale(audio:Int, scale:Float) "os"
	Global SetAudioLooping(audio:Int, looping:Int) "os"
	Global SetAudioPaused(audio:Int, paused:Int) "os"
	Global IsAudioValid:Int(audio:Int) "os"
	Global StopAudio(audio:Int) "os"
	Global Set3DAudioConfig(rolloffScale:Float, dopplerScale:Float, distanceScale:Float) "os"
	Global Create3DAudioListener:Int(entity:Int) "os"
	Global Play3DSound:Int(sound:Int, entity:Int) "os"
	Global Update3DAudio() "os"

	Global _lib:Byte Ptr

	Function LoadSGD(dll_path:String = "sgd_dynamic.dll")

		Local sgd_lib:Byte Ptr = LoadLibraryA(dll_path)
		if Not sgd_lib
			Local msg:String = "Couldn't load " + RealPath (dll_path) + "... check path is correct!"
			?Not Win64
			msg = msg + Chr (10) + Chr (10) + "Note standard DLL is 64-bit: make sure you are compiling in 64-bit mode!" + Chr (10) + Chr (10) + "(MaxIDE 'Program' menu -> Architecture -> x64.)"
			?
			Notify msg,True
			RuntimeError msg
		EndIf
		
		Init = GetProcAddress(sgd_lib, "sgd_Init")
		GetVersion_native = GetProcAddress(sgd_lib, "sgd_GetVersion")
		Terminate = GetProcAddress(sgd_lib, "sgd_Terminate")
		SetConfigVar_native = GetProcAddress(sgd_lib, "sgd_SetConfigVar")
		GetConfigVar_native = GetProcAddress(sgd_lib, "sgd_GetConfigVar")
		Error_native = GetProcAddress(sgd_lib, "sgd_Error")
		Alert_native = GetProcAddress(sgd_lib, "sgd_Alert")
		Log_native = GetProcAddress(sgd_lib, "sgd_Log")
		GetDesktopWidth = GetProcAddress(sgd_lib, "sgd_GetDesktopWidth")
		GetDesktopHeight = GetProcAddress(sgd_lib, "sgd_GetDesktopHeight")
		PollEvents = GetProcAddress(sgd_lib, "sgd_PollEvents")
		ReleaseHandle = GetProcAddress(sgd_lib, "sgd_ReleaseHandle")
		ReleaseAllHandles = GetProcAddress(sgd_lib, "sgd_ReleaseAllHandles")
		DebugMemory = GetProcAddress(sgd_lib, "sgd_DebugMemory")
		CreateWindow_native = GetProcAddress(sgd_lib, "sgd_CreateWindow")
		DestroyWindow = GetProcAddress(sgd_lib, "sgd_DestroyWindow")
		SetWindowPosition = GetProcAddress(sgd_lib, "sgd_SetWindowPosition")
		GetWindowX = GetProcAddress(sgd_lib, "sgd_GetWindowX")
		GetWindowY = GetProcAddress(sgd_lib, "sgd_GetWindowY")
		SetWindowSize = GetProcAddress(sgd_lib, "sgd_SetWindowSize")
		GetWindowWidth = GetProcAddress(sgd_lib, "sgd_GetWindowWidth")
		GetWindowHeight = GetProcAddress(sgd_lib, "sgd_GetWindowHeight")
		SetWindowTitle_native = GetProcAddress(sgd_lib, "sgd_SetWindowTitle")
		GetWindowTitle_native = GetProcAddress(sgd_lib, "sgd_GetWindowTitle")
		SetFullscreenMode = GetProcAddress(sgd_lib, "sgd_SetFullscreenMode")
		SetWindowState = GetProcAddress(sgd_lib, "sgd_SetWindowState")
		GetWindowState = GetProcAddress(sgd_lib, "sgd_GetWindowState")
		IsKeyDown = GetProcAddress(sgd_lib, "sgd_IsKeyDown")
		IsKeyHit = GetProcAddress(sgd_lib, "sgd_IsKeyHit")
		GetChar = GetProcAddress(sgd_lib, "sgd_GetChar")
		FlushChars = GetProcAddress(sgd_lib, "sgd_FlushChars")
		GetMouseX = GetProcAddress(sgd_lib, "sgd_GetMouseX")
		GetMouseY = GetProcAddress(sgd_lib, "sgd_GetMouseY")
		GetMouseZ = GetProcAddress(sgd_lib, "sgd_GetMouseZ")
		GetMouseVX = GetProcAddress(sgd_lib, "sgd_GetMouseVX")
		GetMouseVY = GetProcAddress(sgd_lib, "sgd_GetMouseVY")
		GetMouseVZ = GetProcAddress(sgd_lib, "sgd_GetMouseVZ")
		SetMouseZ = GetProcAddress(sgd_lib, "sgd_SetMouseZ")
		SetMouseCursorMode = GetProcAddress(sgd_lib, "sgd_SetMouseCursorMode")
		IsMouseButtonDown = GetProcAddress(sgd_lib, "sgd_IsMouseButtonDown")
		IsMouseButtonHit = GetProcAddress(sgd_lib, "sgd_IsMouseButtonHit")
		IsGamepadConnected = GetProcAddress(sgd_lib, "sgd_IsGamepadConnected")
		IsGamepadButtonDown = GetProcAddress(sgd_lib, "sgd_IsGamepadButtonDown")
		IsGamepadButtonHit = GetProcAddress(sgd_lib, "sgd_IsGamepadButtonHit")
		GetGamepadAxis = GetProcAddress(sgd_lib, "sgd_GetGamepadAxis")
		Load2DTexture_native = GetProcAddress(sgd_lib, "sgd_Load2DTexture")
		LoadCubeTexture_native = GetProcAddress(sgd_lib, "sgd_LoadCubeTexture")
		LoadArrayTexture_native = GetProcAddress(sgd_lib, "sgd_LoadArrayTexture")
		Create2DTexture = GetProcAddress(sgd_lib, "sgd_Create2DTexture")
		CreateCubeTexture = GetProcAddress(sgd_lib, "sgd_CreateCubeTexture")
		CreateArrayTexture = GetProcAddress(sgd_lib, "sgd_CreateArrayTexture")
		GetTextureType = GetProcAddress(sgd_lib, "sgd_GetTextureType")
		GetTextureWidth = GetProcAddress(sgd_lib, "sgd_GetTextureWidth")
		GetTextureHeight = GetProcAddress(sgd_lib, "sgd_GetTextureHeight")
		GetTextureDepth = GetProcAddress(sgd_lib, "sgd_GetTextureDepth")
		GetTextureFormat = GetProcAddress(sgd_lib, "sgd_GetTextureFormat")
		GetTextureFlags = GetProcAddress(sgd_lib, "sgd_GetTextureFlags")
		SetTexelSRGBA = GetProcAddress(sgd_lib, "sgd_SetTexelSRGBA")
		GetTexelSRGBA = GetProcAddress(sgd_lib, "sgd_GetTexelSRGBA")
		LoadPBRMaterial_native = GetProcAddress(sgd_lib, "sgd_LoadPBRMaterial")
		CreatePBRMaterial = GetProcAddress(sgd_lib, "sgd_CreatePBRMaterial")
		LoadPrelitMaterial_native = GetProcAddress(sgd_lib, "sgd_LoadPrelitMaterial")
		CreatePrelitMaterial = GetProcAddress(sgd_lib, "sgd_CreatePrelitMaterial")
		SetMaterialBlendMode = GetProcAddress(sgd_lib, "sgd_SetMaterialBlendMode")
		SetMaterialDepthFunc = GetProcAddress(sgd_lib, "sgd_SetMaterialDepthFunc")
		SetMaterialCullMode = GetProcAddress(sgd_lib, "sgd_SetMaterialCullMode")
		SetMaterialTexture_native = GetProcAddress(sgd_lib, "sgd_SetMaterialTexture")
		SetMaterialColor_native = GetProcAddress(sgd_lib, "sgd_SetMaterialColor")
		SetMaterialFloat_native = GetProcAddress(sgd_lib, "sgd_SetMaterialFloat")
		LoadMesh_native = GetProcAddress(sgd_lib, "sgd_LoadMesh")
		CopyMesh = GetProcAddress(sgd_lib, "sgd_CopyMesh")
		CreateBoxMesh = GetProcAddress(sgd_lib, "sgd_CreateBoxMesh")
		CreateSphereMesh = GetProcAddress(sgd_lib, "sgd_CreateSphereMesh")
		CreateCylinderMesh = GetProcAddress(sgd_lib, "sgd_CreateCylinderMesh")
		CreateConeMesh = GetProcAddress(sgd_lib, "sgd_CreateConeMesh")
		CreateTorusMesh = GetProcAddress(sgd_lib, "sgd_CreateTorusMesh")
		SetMeshShadowsEnabled = GetProcAddress(sgd_lib, "sgd_SetMeshShadowsEnabled")
		IsMeshShadowsEnabled = GetProcAddress(sgd_lib, "sgd_IsMeshShadowsEnabled")
		UpdateMeshNormals = GetProcAddress(sgd_lib, "sgd_UpdateMeshNormals")
		UpdateMeshTangents = GetProcAddress(sgd_lib, "sgd_UpdateMeshTangents")
		FitMesh = GetProcAddress(sgd_lib, "sgd_FitMesh")
		TransformMesh = GetProcAddress(sgd_lib, "sgd_TransformMesh")
		TransformTexCoords = GetProcAddress(sgd_lib, "sgd_TransformTexCoords")
		FlipMesh = GetProcAddress(sgd_lib, "sgd_FlipMesh")
		GetMeshBoundsMinX = GetProcAddress(sgd_lib, "sgd_GetMeshBoundsMinX")
		GetMeshBoundsMinY = GetProcAddress(sgd_lib, "sgd_GetMeshBoundsMinY")
		GetMeshBoundsMinZ = GetProcAddress(sgd_lib, "sgd_GetMeshBoundsMinZ")
		GetMeshBoundsMaxX = GetProcAddress(sgd_lib, "sgd_GetMeshBoundsMaxX")
		GetMeshBoundsMaxY = GetProcAddress(sgd_lib, "sgd_GetMeshBoundsMaxY")
		GetMeshBoundsMaxZ = GetProcAddress(sgd_lib, "sgd_GetMeshBoundsMaxZ")
		CreateMesh = GetProcAddress(sgd_lib, "sgd_CreateMesh")
		ResizeVertices = GetProcAddress(sgd_lib, "sgd_ResizeVertices")
		GetVertexCount = GetProcAddress(sgd_lib, "sgd_GetVertexCount")
		AddVertex = GetProcAddress(sgd_lib, "sgd_AddVertex")
		SetVertex = GetProcAddress(sgd_lib, "sgd_SetVertex")
		SetVertexPosition = GetProcAddress(sgd_lib, "sgd_SetVertexPosition")
		SetVertexNormal = GetProcAddress(sgd_lib, "sgd_SetVertexNormal")
		SetVertexTangent = GetProcAddress(sgd_lib, "sgd_SetVertexTangent")
		SetVertexColor = GetProcAddress(sgd_lib, "sgd_SetVertexColor")
		SetVertexTexCoord0 = GetProcAddress(sgd_lib, "sgd_SetVertexTexCoord0")
		GetVertexX = GetProcAddress(sgd_lib, "sgd_GetVertexX")
		GetVertexY = GetProcAddress(sgd_lib, "sgd_GetVertexY")
		GetVertexZ = GetProcAddress(sgd_lib, "sgd_GetVertexZ")
		GetVertexNX = GetProcAddress(sgd_lib, "sgd_GetVertexNX")
		GetVertexNY = GetProcAddress(sgd_lib, "sgd_GetVertexNY")
		GetVertexNZ = GetProcAddress(sgd_lib, "sgd_GetVertexNZ")
		GetVertexTX = GetProcAddress(sgd_lib, "sgd_GetVertexTX")
		GetVertexTY = GetProcAddress(sgd_lib, "sgd_GetVertexTY")
		GetVertexTZ = GetProcAddress(sgd_lib, "sgd_GetVertexTZ")
		GetVertexTW = GetProcAddress(sgd_lib, "sgd_GetVertexTW")
		GetVertexRed = GetProcAddress(sgd_lib, "sgd_GetVertexRed")
		GetVertexGreen = GetProcAddress(sgd_lib, "sgd_GetVertexGreen")
		GetVertexBlue = GetProcAddress(sgd_lib, "sgd_GetVertexBlue")
		GetVertexAlpha = GetProcAddress(sgd_lib, "sgd_GetVertexAlpha")
		GetVertexU0 = GetProcAddress(sgd_lib, "sgd_GetVertexU0")
		GetVertexV0 = GetProcAddress(sgd_lib, "sgd_GetVertexV0")
		CreateSurface = GetProcAddress(sgd_lib, "sgd_CreateSurface")
		GetSurfaceCount = GetProcAddress(sgd_lib, "sgd_GetSurfaceCount")
		GetSurface = GetProcAddress(sgd_lib, "sgd_GetSurface")
		GetMaterial = GetProcAddress(sgd_lib, "sgd_GetMaterial")
		ResizeTriangles = GetProcAddress(sgd_lib, "sgd_ResizeTriangles")
		GetTriangleCount = GetProcAddress(sgd_lib, "sgd_GetTriangleCount")
		AddTriangle = GetProcAddress(sgd_lib, "sgd_AddTriangle")
		SetTriangle = GetProcAddress(sgd_lib, "sgd_SetTriangle")
		GetTriangleVertex = GetProcAddress(sgd_lib, "sgd_GetTriangleVertex")
		LoadFont_native = GetProcAddress(sgd_lib, "sgd_LoadFont")
		GetTextWidth_native = GetProcAddress(sgd_lib, "sgd_GetTextWidth")
		GetFontHeight = GetProcAddress(sgd_lib, "sgd_GetFontHeight")
		LoadImage_native = GetProcAddress(sgd_lib, "sgd_LoadImage")
		LoadArrayImage_native = GetProcAddress(sgd_lib, "sgd_LoadArrayImage")
		CreateImage = GetProcAddress(sgd_lib, "sgd_CreateImage")
		SetImageViewMode = GetProcAddress(sgd_lib, "sgd_SetImageViewMode")
		SetImageBlendMode = GetProcAddress(sgd_lib, "sgd_SetImageBlendMode")
		SetImageRect = GetProcAddress(sgd_lib, "sgd_SetImageRect")
		GetImageTexture = GetProcAddress(sgd_lib, "sgd_GetImageTexture")
		Set2DFillColor = GetProcAddress(sgd_lib, "sgd_Set2DFillColor")
		Set2DFillMaterial = GetProcAddress(sgd_lib, "sgd_Set2DFillMaterial")
		Set2DFillEnabled = GetProcAddress(sgd_lib, "sgd_Set2DFillEnabled")
		Set2DOutlineColor = GetProcAddress(sgd_lib, "sgd_Set2DOutlineColor")
		Set2DOutlineWidth = GetProcAddress(sgd_lib, "sgd_Set2DOutlineWidth")
		Set2DOutlineEnabled = GetProcAddress(sgd_lib, "sgd_Set2DOutlineEnabled")
		Set2DLineWidth = GetProcAddress(sgd_lib, "sgd_Set2DLineWidth")
		Set2DPointSize = GetProcAddress(sgd_lib, "sgd_Set2DPointSize")
		Set2DFont = GetProcAddress(sgd_lib, "sgd_Set2DFont")
		Set2DTextColor = GetProcAddress(sgd_lib, "sgd_Set2DTextColor")
		Get2DTextWidth_native = GetProcAddress(sgd_lib, "sgd_Get2DTextWidth")
		Get2DFontHeight = GetProcAddress(sgd_lib, "sgd_Get2DFontHeight")
		Clear2D = GetProcAddress(sgd_lib, "sgd_Clear2D")
		Push2DLayer = GetProcAddress(sgd_lib, "sgd_Push2DLayer")
		Pop2DLayer = GetProcAddress(sgd_lib, "sgd_Pop2DLayer")
		Draw2DPoint = GetProcAddress(sgd_lib, "sgd_Draw2DPoint")
		Draw2DLine = GetProcAddress(sgd_lib, "sgd_Draw2DLine")
		Draw2DRect = GetProcAddress(sgd_lib, "sgd_Draw2DRect")
		Draw2DImage = GetProcAddress(sgd_lib, "sgd_Draw2DImage")
		Draw2DOval = GetProcAddress(sgd_lib, "sgd_Draw2DOval")
		Draw2DText_native = GetProcAddress(sgd_lib, "sgd_Draw2DText")
		ClearScene = GetProcAddress(sgd_lib, "sgd_ClearScene")
		ResetScene = GetProcAddress(sgd_lib, "sgd_ResetScene")
		LoadScene_native = GetProcAddress(sgd_lib, "sgd_LoadScene")
		SaveScene_native = GetProcAddress(sgd_lib, "sgd_SaveScene")
		SetAmbientLightColor = GetProcAddress(sgd_lib, "sgd_SetAmbientLightColor")
		SetClearColor = GetProcAddress(sgd_lib, "sgd_SetClearColor")
		SetClearDepth = GetProcAddress(sgd_lib, "sgd_SetClearDepth")
		SetEnvTexture = GetProcAddress(sgd_lib, "sgd_SetEnvTexture")
		UpdateShadowMappingConfig = GetProcAddress(sgd_lib, "sgd_UpdateShadowMappingConfig")
		RenderScene = GetProcAddress(sgd_lib, "sgd_RenderScene")
		Present = GetProcAddress(sgd_lib, "sgd_Present")
		GetFPS = GetProcAddress(sgd_lib, "sgd_GetFPS")
		GetRPS = GetProcAddress(sgd_lib, "sgd_GetRPS")
		SetEntityEnabled = GetProcAddress(sgd_lib, "sgd_SetEntityEnabled")
		IsEntityEnabled = GetProcAddress(sgd_lib, "sgd_IsEntityEnabled")
		SetEntityVisible = GetProcAddress(sgd_lib, "sgd_SetEntityVisible")
		IsEntityVisible = GetProcAddress(sgd_lib, "sgd_IsEntityVisible")
		DestroyEntity = GetProcAddress(sgd_lib, "sgd_DestroyEntity")
		ResetEntity = GetProcAddress(sgd_lib, "sgd_ResetEntity")
		CopyEntity = GetProcAddress(sgd_lib, "sgd_CopyEntity")
		SetEntityName_native = GetProcAddress(sgd_lib, "sgd_SetEntityName")
		GetEntityName_native = GetProcAddress(sgd_lib, "sgd_GetEntityName")
		SetEntityParent = GetProcAddress(sgd_lib, "sgd_SetEntityParent")
		GetEntityParent = GetProcAddress(sgd_lib, "sgd_GetEntityParent")
		GetEntityChildCount = GetProcAddress(sgd_lib, "sgd_GetEntityChildCount")
		GetEntityChild = GetProcAddress(sgd_lib, "sgd_GetEntityChild")
		FindEntityChild_native = GetProcAddress(sgd_lib, "sgd_FindEntityChild")
		SetEntityPosition = GetProcAddress(sgd_lib, "sgd_SetEntityPosition")
		SetEntityRotation = GetProcAddress(sgd_lib, "sgd_SetEntityRotation")
		SetEntityScale = GetProcAddress(sgd_lib, "sgd_SetEntityScale")
		TranslateEntity = GetProcAddress(sgd_lib, "sgd_TranslateEntity")
		RotateEntity = GetProcAddress(sgd_lib, "sgd_RotateEntity")
		ScaleEntity = GetProcAddress(sgd_lib, "sgd_ScaleEntity")
		MoveEntity = GetProcAddress(sgd_lib, "sgd_MoveEntity")
		TurnEntity = GetProcAddress(sgd_lib, "sgd_TurnEntity")
		GetEntityX = GetProcAddress(sgd_lib, "sgd_GetEntityX")
		GetEntityY = GetProcAddress(sgd_lib, "sgd_GetEntityY")
		GetEntityZ = GetProcAddress(sgd_lib, "sgd_GetEntityZ")
		GetEntityRX = GetProcAddress(sgd_lib, "sgd_GetEntityRX")
		GetEntityRY = GetProcAddress(sgd_lib, "sgd_GetEntityRY")
		GetEntityRZ = GetProcAddress(sgd_lib, "sgd_GetEntityRZ")
		GetEntitySX = GetProcAddress(sgd_lib, "sgd_GetEntitySX")
		GetEntitySY = GetProcAddress(sgd_lib, "sgd_GetEntitySY")
		GetEntitySZ = GetProcAddress(sgd_lib, "sgd_GetEntitySZ")
		GetEntityIX = GetProcAddress(sgd_lib, "sgd_GetEntityIX")
		GetEntityIY = GetProcAddress(sgd_lib, "sgd_GetEntityIY")
		GetEntityIZ = GetProcAddress(sgd_lib, "sgd_GetEntityIZ")
		GetEntityJX = GetProcAddress(sgd_lib, "sgd_GetEntityJX")
		GetEntityJY = GetProcAddress(sgd_lib, "sgd_GetEntityJY")
		GetEntityJZ = GetProcAddress(sgd_lib, "sgd_GetEntityJZ")
		GetEntityKX = GetProcAddress(sgd_lib, "sgd_GetEntityKX")
		GetEntityKY = GetProcAddress(sgd_lib, "sgd_GetEntityKY")
		GetEntityKZ = GetProcAddress(sgd_lib, "sgd_GetEntityKZ")
		AimEntityAtEntity = GetProcAddress(sgd_lib, "sgd_AimEntityAtEntity")
		AimEntityAtPoint = GetProcAddress(sgd_lib, "sgd_AimEntityAtPoint")
		TransformPoint = GetProcAddress(sgd_lib, "sgd_TransformPoint")
		TransformVector = GetProcAddress(sgd_lib, "sgd_TransformVector")
		TransformNormal = GetProcAddress(sgd_lib, "sgd_TransformNormal")
		GetTransformedX = GetProcAddress(sgd_lib, "sgd_GetTransformedX")
		GetTransformedY = GetProcAddress(sgd_lib, "sgd_GetTransformedY")
		GetTransformedZ = GetProcAddress(sgd_lib, "sgd_GetTransformedZ")
		CreatePerspectiveCamera = GetProcAddress(sgd_lib, "sgd_CreatePerspectiveCamera")
		CreateOrthographicCamera = GetProcAddress(sgd_lib, "sgd_CreateOrthographicCamera")
		GetCameraType = GetProcAddress(sgd_lib, "sgd_GetCameraType")
		SetCameraFOV = GetProcAddress(sgd_lib, "sgd_SetCameraFOV")
		SetCameraNear = GetProcAddress(sgd_lib, "sgd_SetCameraNear")
		SetCameraFar = GetProcAddress(sgd_lib, "sgd_SetCameraFar")
		CameraProject = GetProcAddress(sgd_lib, "sgd_CameraProject")
		GetProjectedX = GetProcAddress(sgd_lib, "sgd_GetProjectedX")
		GetProjectedY = GetProcAddress(sgd_lib, "sgd_GetProjectedY")
		CameraUnproject = GetProcAddress(sgd_lib, "sgd_CameraUnproject")
		GetUnprojectedX = GetProcAddress(sgd_lib, "sgd_GetUnprojectedX")
		GetUnprojectedY = GetProcAddress(sgd_lib, "sgd_GetUnprojectedY")
		GetUnprojectedZ = GetProcAddress(sgd_lib, "sgd_GetUnprojectedZ")
		CreateDirectionalLight = GetProcAddress(sgd_lib, "sgd_CreateDirectionalLight")
		CreatePointLight = GetProcAddress(sgd_lib, "sgd_CreatePointLight")
		CreateSpotLight = GetProcAddress(sgd_lib, "sgd_CreateSpotLight")
		GetLightType = GetProcAddress(sgd_lib, "sgd_GetLightType")
		SetLightShadowsEnabled = GetProcAddress(sgd_lib, "sgd_SetLightShadowsEnabled")
		IsLightShadowsEnabled = GetProcAddress(sgd_lib, "sgd_IsLightShadowsEnabled")
		SetLightPriority = GetProcAddress(sgd_lib, "sgd_SetLightPriority")
		GetLightPriority = GetProcAddress(sgd_lib, "sgd_GetLightPriority")
		SetLightColor = GetProcAddress(sgd_lib, "sgd_SetLightColor")
		SetLightRange = GetProcAddress(sgd_lib, "sgd_SetLightRange")
		SetLightFalloff = GetProcAddress(sgd_lib, "sgd_SetLightFalloff")
		SetLightInnerConeAngle = GetProcAddress(sgd_lib, "sgd_SetLightInnerConeAngle")
		SetLightOuterConeAngle = GetProcAddress(sgd_lib, "sgd_SetLightOuterConeAngle")
		LoadModel_native = GetProcAddress(sgd_lib, "sgd_LoadModel")
		LoadBonedModel_native = GetProcAddress(sgd_lib, "sgd_LoadBonedModel")
		CreateModel = GetProcAddress(sgd_lib, "sgd_CreateModel")
		SetModelMesh = GetProcAddress(sgd_lib, "sgd_SetModelMesh")
		GetModelMesh = GetProcAddress(sgd_lib, "sgd_GetModelMesh")
		SetModelColor = GetProcAddress(sgd_lib, "sgd_SetModelColor")
		AnimateModel = GetProcAddress(sgd_lib, "sgd_AnimateModel")
		LoadSkybox_native = GetProcAddress(sgd_lib, "sgd_LoadSkybox")
		CreateSkybox = GetProcAddress(sgd_lib, "sgd_CreateSkybox")
		SetSkyboxTexture = GetProcAddress(sgd_lib, "sgd_SetSkyboxTexture")
		SetSkyboxRoughness = GetProcAddress(sgd_lib, "sgd_SetSkyboxRoughness")
		CreateTerrain = GetProcAddress(sgd_lib, "sgd_CreateTerrain")
		SetTerrainSize = GetProcAddress(sgd_lib, "sgd_SetTerrainSize")
		SetTerrainLODs = GetProcAddress(sgd_lib, "sgd_SetTerrainLODs")
		SetTerrainMaterial = GetProcAddress(sgd_lib, "sgd_SetTerrainMaterial")
		SetTerrainMaterialSize = GetProcAddress(sgd_lib, "sgd_SetTerrainMaterialSize")
		SetTerrainHeightTexture = GetProcAddress(sgd_lib, "sgd_SetTerrainHeightTexture")
		SetTerrainNormalTexture = GetProcAddress(sgd_lib, "sgd_SetTerrainNormalTexture")
		SetTerrainDebugMode = GetProcAddress(sgd_lib, "sgd_SetTerrainDebugMode")
		CreateSprite = GetProcAddress(sgd_lib, "sgd_CreateSprite")
		SetSpriteImage = GetProcAddress(sgd_lib, "sgd_SetSpriteImage")
		SetSpriteColor = GetProcAddress(sgd_lib, "sgd_SetSpriteColor")
		SetSpriteFrame = GetProcAddress(sgd_lib, "sgd_SetSpriteFrame")
		CreateSphereCollider = GetProcAddress(sgd_lib, "sgd_CreateSphereCollider")
		CreateEllipsoidCollider = GetProcAddress(sgd_lib, "sgd_CreateEllipsoidCollider")
		CreateMeshCollider = GetProcAddress(sgd_lib, "sgd_CreateMeshCollider")
		GetColliderEntity = GetProcAddress(sgd_lib, "sgd_GetColliderEntity")
		GetColliderType = GetProcAddress(sgd_lib, "sgd_GetColliderType")
		SetColliderRadius = GetProcAddress(sgd_lib, "sgd_SetColliderRadius")
		SetColliderHeight = GetProcAddress(sgd_lib, "sgd_SetColliderHeight")
		EnableCollisions = GetProcAddress(sgd_lib, "sgd_EnableCollisions")
		UpdateColliders = GetProcAddress(sgd_lib, "sgd_UpdateColliders")
		GetCollisionCount = GetProcAddress(sgd_lib, "sgd_GetCollisionCount")
		GetCollisionCollider = GetProcAddress(sgd_lib, "sgd_GetCollisionCollider")
		GetCollisionX = GetProcAddress(sgd_lib, "sgd_GetCollisionX")
		GetCollisionY = GetProcAddress(sgd_lib, "sgd_GetCollisionY")
		GetCollisionZ = GetProcAddress(sgd_lib, "sgd_GetCollisionZ")
		GetCollisionNX = GetProcAddress(sgd_lib, "sgd_GetCollisionNX")
		GetCollisionNY = GetProcAddress(sgd_lib, "sgd_GetCollisionNY")
		GetCollisionNZ = GetProcAddress(sgd_lib, "sgd_GetCollisionNZ")
		CameraPick = GetProcAddress(sgd_lib, "sgd_CameraPick")
		LinePick = GetProcAddress(sgd_lib, "sgd_LinePick")
		GetPickedX = GetProcAddress(sgd_lib, "sgd_GetPickedX")
		GetPickedY = GetProcAddress(sgd_lib, "sgd_GetPickedY")
		GetPickedZ = GetProcAddress(sgd_lib, "sgd_GetPickedZ")
		GetPickedNX = GetProcAddress(sgd_lib, "sgd_GetPickedNX")
		GetPickedNY = GetProcAddress(sgd_lib, "sgd_GetPickedNY")
		GetPickedNZ = GetProcAddress(sgd_lib, "sgd_GetPickedNZ")
		CreateBloomEffect = GetProcAddress(sgd_lib, "sgd_CreateBloomEffect")
		SetBloomEffectRadius = GetProcAddress(sgd_lib, "sgd_SetBloomEffectRadius")
		GetBloomEffectRadius = GetProcAddress(sgd_lib, "sgd_GetBloomEffectRadius")
		CreateBlurEffect = GetProcAddress(sgd_lib, "sgd_CreateBlurEffect")
		SetBlurEffectRadius = GetProcAddress(sgd_lib, "sgd_SetBlurEffectRadius")
		GetBlurEffectRadius = GetProcAddress(sgd_lib, "sgd_GetBlurEffectRadius")
		CreateFogEffect = GetProcAddress(sgd_lib, "sgd_CreateFogEffect")
		SetFogEffectColor = GetProcAddress(sgd_lib, "sgd_SetFogEffectColor")
		SetFogEffectRange = GetProcAddress(sgd_lib, "sgd_SetFogEffectRange")
		SetFogEffectPower = GetProcAddress(sgd_lib, "sgd_SetFogEffectPower")
		CreateMonocolorEffect = GetProcAddress(sgd_lib, "sgd_CreateMonocolorEffect")
		SetMonocolorEffectColor = GetProcAddress(sgd_lib, "sgd_SetMonocolorEffectColor")
		SetRenderEffectEnabled = GetProcAddress(sgd_lib, "sgd_SetRenderEffectEnabled")
		IsRenderEffectEnabled = GetProcAddress(sgd_lib, "sgd_IsRenderEffectEnabled")
		LoadSound_native = GetProcAddress(sgd_lib, "sgd_LoadSound")
		PlaySound = GetProcAddress(sgd_lib, "sgd_PlaySound")
		CueSound = GetProcAddress(sgd_lib, "sgd_CueSound")
		SetAudioVolume = GetProcAddress(sgd_lib, "sgd_SetAudioVolume")
		SetAudioPan = GetProcAddress(sgd_lib, "sgd_SetAudioPan")
		SetAudioPitchScale = GetProcAddress(sgd_lib, "sgd_SetAudioPitchScale")
		SetAudioLooping = GetProcAddress(sgd_lib, "sgd_SetAudioLooping")
		SetAudioPaused = GetProcAddress(sgd_lib, "sgd_SetAudioPaused")
		IsAudioValid = GetProcAddress(sgd_lib, "sgd_IsAudioValid")
		StopAudio = GetProcAddress(sgd_lib, "sgd_StopAudio")
		Set3DAudioConfig = GetProcAddress(sgd_lib, "sgd_Set3DAudioConfig")
		Create3DAudioListener = GetProcAddress(sgd_lib, "sgd_Create3DAudioListener")
		Play3DSound = GetProcAddress(sgd_lib, "sgd_Play3DSound")
		Update3DAudio = GetProcAddress(sgd_lib, "sgd_Update3DAudio")
	
	End Function
	
End Type
