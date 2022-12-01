extends HBoxContainer

onready var ResolutionOptionButton = $VideoOptionsVBoxContainer/ResolutionHBoxContainer/ResolutionOptionButton
onready var FullscreenCheckBox = $VideoOptionsVBoxContainer/FullscreenHBoxContainer/FullscreenCheckBox
onready var VsyncCheckBox = $VideoOptionsVBoxContainer/VsyncHBoxContainer/VsyncCheckBox
onready var FXAACheckBox = $VideoOptionsVBoxContainer/FXAAHBoxContainer/FXAACheckBox
onready var MSAAOptionButton = $VideoOptionsVBoxContainer/MSAAHBoxContainer/MSAAOptionButton


func _ready():
	FullscreenCheckBox.set_pressed_no_signal(ConfigControl.get_fullscreen_is_activ())
	VsyncCheckBox.set_pressed_no_signal(ConfigControl.get_vsync_is_activ())
	FXAACheckBox.set_pressed_no_signal(ConfigControl.get_fxaa_is_activ())
	MSAAOptionButton.set_pressed_no_signal(VideoControl.msaa_modes[ConfigControl.get_msaa_mode()])
	ResolutionOptionButton.set_disabled(ConfigControl.get_fullscreen_is_activ())
	
	add_resolutions()
	add_msaa_modes()

	
func add_resolutions():
	var CurrentResolution = VideoControl.window_resolutions[ConfigControl.get_window_resolution()]

	var index = 0
	
	for resolution in VideoControl.window_resolutions:
		ResolutionOptionButton.add_item(resolution, index)
		
		if VideoControl.window_resolutions[resolution] == CurrentResolution:
			ResolutionOptionButton._select_int(index)
			
		index += 1

func add_msaa_modes():
	var index = 0
	var CurrentMsaaMode = VideoControl.msaa_modes[ConfigControl.get_msaa_mode()]
	
	for mode in VideoControl.msaa_modes:
		MSAAOptionButton.add_item(mode,index)
		if VideoControl.msaa_modes[mode] == CurrentMsaaMode:
			MSAAOptionButton._select_int(index)
		
		
		index += 1

func _on_ResolutionOptionButton_item_selected(index):
	var selected_resolution_as_text =ResolutionOptionButton.get_item_text(index)
	VideoControl.update_window_resolution(selected_resolution_as_text)




func _on_FullscreenCheckBox_toggled(button_pressed):
	var max_resolution_as_text = VideoControl.activate_window_fullscreen(button_pressed)
	ResolutionOptionButton.set_disabled(button_pressed)
	ResolutionOptionButton.set_text(max_resolution_as_text)

func _on_VsyncCheckBox_toggled(button_pressed):
	VideoControl.activate_vsync(button_pressed)


func _on_FXAACheckBox_toggled(button_pressed):
	VideoControl.activate_fxaa(button_pressed)


func _on_MSAAOptionButton_item_selected(index):
	var selected_msaa_mode = MSAAOptionButton.get_item_text(index)
	VideoControl.update_msaa_mode(selected_msaa_mode)
	
