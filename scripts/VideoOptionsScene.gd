extends HBoxContainer

onready var resolution_option_button = $VideoOptionsVBoxContainer/ResolutionHBoxContainer/ResolutionOptionButton
onready var fullscreen_check_box = $VideoOptionsVBoxContainer/FullscreenHBoxContainer/FullscreenCheckBox
onready var vsync_check_box = $VideoOptionsVBoxContainer/VsyncHBoxContainer/VsyncCheckBox
onready var fxaa_check_box = $VideoOptionsVBoxContainer/FXAAHBoxContainer/FXAACheckBox
onready var msaa_option_Button = $VideoOptionsVBoxContainer/MSAAHBoxContainer/MSAAOptionButton

func _ready():
	fullscreen_check_box.set_pressed_no_signal(ConfigControl.get_fullscreen_is_activ())
	vsync_check_box.set_pressed_no_signal(ConfigControl.get_vsync_is_activ())
	fxaa_check_box.set_pressed_no_signal(ConfigControl.get_fxaa_is_activ())
	msaa_option_Button.set_pressed_no_signal(VideoControl.msaa_modes[ConfigControl.get_msaa_mode()])
	resolution_option_button.set_disabled(ConfigControl.get_fullscreen_is_activ())
	
	add_resolutions()
	add_msaa_modes()


	
func add_resolutions():

	var CurrentResolution = VideoControl.window_resolutions[ConfigControl.get_window_resolution()]

	var index = 0
	
	for resolution in VideoControl.window_resolutions:
		resolution_option_button.add_item(resolution, index)
		
		if VideoControl.window_resolutions[resolution] == CurrentResolution:
			resolution_option_button._select_int(index)
			
		index += 1

func add_msaa_modes():
	var index = 0
	var CurrentMsaaMode = VideoControl.msaa_modes[ConfigControl.get_msaa_mode()]
	
	for mode in VideoControl.msaa_modes:
		msaa_option_Button.add_item(mode,index)
		if VideoControl.msaa_modes[mode] == CurrentMsaaMode:
			msaa_option_Button._select_int(index)
		
		
		index += 1

func _on_ResolutionOptionButton_item_selected(index):
	var selected_resolution_as_text = resolution_option_button.get_item_text(index)
	VideoControl.update_window_resolution(selected_resolution_as_text)




func _on_FullscreenCheckBox_toggled(button_pressed):
	VideoControl.activate_window_fullscreen(button_pressed)
	resolution_option_button.set_disabled(button_pressed)

func _on_VsyncCheckBox_toggled(button_pressed):
	VideoControl.activate_vsync(button_pressed)


func _on_FXAACheckBox_toggled(button_pressed):
	VideoControl.activate_fxaa(button_pressed)


func _on_MSAAOptionButton_item_selected(index):
	var selected_msaa_mode = msaa_option_Button.get_item_text(index)
	VideoControl.update_msaa_mode(selected_msaa_mode)
	
