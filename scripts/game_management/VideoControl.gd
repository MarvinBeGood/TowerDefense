extends Node

var window_resolutions: Dictionary = {"3840x2160":Vector2(3840,2160),
								"2560x1440":Vector2(2560,1440),
								"1920x1080":Vector2(1920,1080),
								"1366x768":Vector2(1366,768),
								"1536x864":Vector2(1536,864),
								"1280x720":Vector2(1280,720),
								"1440x900":Vector2(1440,900),
								"1600x900":Vector2(1600,900),
								"1024x600":Vector2(1024,600),
								"800x600": Vector2(800,600)}


var msaa_modes: Dictionary = {"Disabled": 0,
								"x2":1,
								"x4":2,
								"x8":3,
								"x16":4}


func _ready():
	OS.set_window_size(window_resolutions[ConfigControl.get_window_resolution()])
	OS.set_window_fullscreen(ConfigControl.get_fullscreen_is_activ())
	OS.set_use_vsync(ConfigControl.get_vsync_is_activ())
	OS.set_window_resizable(ConfigControl.get_window_resizable())
	OS.center_window()
	get_viewport().set_use_fxaa(ConfigControl.get_fxaa_is_activ())
	get_viewport().set_msaa(msaa_modes[ConfigControl.get_msaa_mode()])


func update_window_resolution(resolution:String)->void:
	var selected_resolution = window_resolutions.get(resolution)
	OS.set_window_size(selected_resolution)
	OS.center_window()
	ConfigControl.set_window_resolution(resolution,true)
	ConfigControl.save_config()


func activate_window_fullscreen(activate:bool)->String:
	OS.set_window_fullscreen(activate)
	var max_resolution_as_text = String(OS.get_screen_size().x)+"x"+String(OS.get_screen_size().y)
	if !activate:
		var default_resolution_as_text = "1920x1080"
		OS.set_window_size(VideoControl.window_resolutions[default_resolution_as_text])
		OS.center_window()
		max_resolution_as_text = default_resolution_as_text
	
	OS.set_window_resizable(!activate)
	ConfigControl.set_window_resolution(max_resolution_as_text,true)
	ConfigControl.set_window_resizable(!activate,true)
	ConfigControl.set_fullscreen_is_activ(activate,true)
	ConfigControl.save_config()
	return max_resolution_as_text


func activate_vsync(activate:bool)->void:
	OS.set_use_vsync(activate)
	ConfigControl.set_vsync_is_activ(activate,true)
	ConfigControl.save_config()

func activate_fxaa(activate:bool)->void:
	get_viewport().set_use_fxaa(activate)
	ConfigControl.set_fxaa_is_activ(activate,true)
	ConfigControl.save_config()

func update_msaa_mode(msaa_mode:String)->void:
	get_viewport().set_msaa(msaa_modes[msaa_mode])
	ConfigControl.set_msaa_mode(msaa_mode,true)
	ConfigControl.save_config()
