extends HBoxContainer

onready var ResolutionOptionButton = $VideoOptionsVBoxContainer/ResolutionHBoxContainer/ResolutionOptionButton
onready var FullscreenCheckBox = $VideoOptionsVBoxContainer/FullscreenHBoxContainer/FullscreenCheckBox
onready var VsyncCheckBox = $VideoOptionsVBoxContainer/VsyncHBoxContainer/VsyncCheckBox
onready var FXAACheckBox = $VideoOptionsVBoxContainer/FXAAHBoxContainer/FXAACheckBox
onready var MSAAOptionButton = $VideoOptionsVBoxContainer/MSAAHBoxContainer/MSAAOptionButton



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
	FullscreenCheckBox.set_pressed_no_signal(OS.is_window_fullscreen())
	VsyncCheckBox.set_pressed_no_signal(OS.is_vsync_enabled())
	FXAACheckBox.set_pressed_no_signal(OS.is_vsync_enabled())
	ResolutionOptionButton.set_disabled(OS.is_window_fullscreen())
	AddResolutions()
	AddMsaaModes()
	
func AddMsaaModes():
	var index = 0
	for mode in msaa_modes:
		MSAAOptionButton.add_item(mode,index)
		
		index += 1
	
func AddResolutions():
	var CurrentResolution = get_viewport().get_size()

	var index = 0
	
	for resolution in window_resolutions:
		ResolutionOptionButton.add_item(resolution, index)
		
		if window_resolutions[resolution] == CurrentResolution:
			ResolutionOptionButton._select_int(index)
		index += 1


func _on_ResolutionOptionButton_item_selected(index):
	var selected_resolution = window_resolutions.get(ResolutionOptionButton.get_item_text(index))
	OS.set_window_size(selected_resolution)
	OS.center_window()



func _on_FullscreenCheckBox_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)
	var current_window_size = String(OS.get_screen_size().x)+"x"+String(OS.get_screen_size().y)
	ResolutionOptionButton.set_disabled(button_pressed)
	ResolutionOptionButton.set_text(current_window_size)
	
	if !button_pressed:
		var default_resolution_index = window_resolutions.keys().find("1920x1080")
		ResolutionOptionButton._select_int(default_resolution_index)
		var default_resolution_as_text = ResolutionOptionButton.get_item_text(default_resolution_index)
		ResolutionOptionButton.set_text(default_resolution_as_text)

		
		OS.set_window_size(window_resolutions[default_resolution_as_text])
		OS.center_window()

	#OS.set_window_resizable(button_pressed)


func _on_VsyncCheckBox_toggled(button_pressed):
	OS.set_use_vsync(button_pressed)


func _on_FXAACheckBox_toggled(button_pressed):
	get_viewport().set_use_fxaa(button_pressed)


func _on_MSAAOptionButton_item_selected(index):
	get_viewport().set_msaa(msaa_modes[MSAAOptionButton.get_item_text(index)])


