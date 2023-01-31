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
								"x8":3 
								}
var default_resolution = "1024x600"

var max_window_resolution = String(OS.get_screen_size().x)+"x"+String(OS.get_screen_size().y)

func _ready():

	OS.set_window_size(window_resolutions.get(ConfigControl.get_window_resolution()))
	OS.set_window_fullscreen(ConfigControl.get_fullscreen_is_activ())
	OS.set_use_vsync(ConfigControl.get_vsync_is_activ())
	OS.set_window_resizable(false)
	OS.center_window()
	get_viewport().set_use_fxaa(ConfigControl.get_fxaa_is_activ())
	get_viewport().set_msaa(msaa_modes[ConfigControl.get_msaa_mode()])


func update_window_resolution(resolution:String)->void:
	var selected_resolution = window_resolutions.get(resolution)
	OS.set_window_size(selected_resolution)
	OS.center_window()
	ConfigControl.set_window_resolution(resolution,true)
	ConfigControl.save_config()


func activate_window_fullscreen(activate:bool)->void:
	OS.set_window_fullscreen(activate)
	if !activate:
		OS.set_window_size(VideoControl.window_resolutions[ConfigControl.get_window_resolution()])
		OS.center_window()
	
	OS.set_window_resizable(false)
	ConfigControl.set_window_resizable(false,true)
	ConfigControl.set_fullscreen_is_activ(activate,true)
	ConfigControl.save_config()


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

#func get_index_for_key_in_dict(expected_key:String,dictionary)->int:
#	var index = 0
#	
#	for entry in dictionary:
#		if entry  == expected_key:
#			return index
#		index += 1
#	return 0
