extends Node

var config_data = {}


const config_filepath = "user://towerdefense_config.ini"
const player_name = "player"
var config = ConfigFile.new()

const options: Dictionary = {
	window_resolution= "window_resolution",
	fullscreen_is_activ = "fullscreen_is_activ",
	window_resizable="window_resizable",
	vsync_is_activ="vsync_is_activ",
	fxaa_is_activ="fxaa_is_activ",
	msaa_mode="msaa_mode",
	master_volume="master_volume",
	music_volume="music_volume",
	effect_volume="effect_volume"
}


func load_config_or_set_default_config():
	
	config.load(config_filepath)

	set_window_resolution(String(OS.get_screen_size().x)+"x"+String(OS.get_screen_size().y))

	set_fullscreen_is_activ(true)

	set_window_resizable(false)

	set_vsync_is_activ(false)

	set_fxaa_is_activ(false)

	set_msaa_mode("Disabled")
	
	set_master_volume(-25)

	set_music_volume(-25)

	set_effect_volume(-25)
		
func _ready():
	load_config_or_set_default_config()
	save_config()


func check_if_key_value_should_be_overwritten(key_name:String,overwrite:bool)-> bool:
	return !config.has_section_key(player_name,key_name) || overwrite


func set_window_resolution(window_resolution:String,overwrite:bool=false)-> void:
	var key_name = options.window_resolution
	if check_if_key_value_should_be_overwritten(key_name,overwrite):
		config.set_value(player_name,key_name,window_resolution)

func set_window_resizable(window_resizable:bool,overwrite:bool=false)->void:
	var key_name = options.window_resizable
	if check_if_key_value_should_be_overwritten(key_name,overwrite):
		config.set_value(player_name,key_name,window_resizable)

func set_fullscreen_is_activ(fullscreen_is_activ:bool,overwrite:bool=false)-> void:
	var key_name = options.fullscreen_is_activ
	if check_if_key_value_should_be_overwritten(key_name,overwrite):
		config.set_value(player_name,key_name,fullscreen_is_activ)

func set_vsync_is_activ(vsync_is_activ:bool,overwrite:bool=false)-> void:
	var key_name = options.vsync_is_activ
	if check_if_key_value_should_be_overwritten(key_name,overwrite):
		config.set_value(player_name,key_name,vsync_is_activ)

func set_fxaa_is_activ(fxaa_is_activ:bool,overwrite:bool=false)-> void:
	var key_name = options.fxaa_is_activ
	if check_if_key_value_should_be_overwritten(key_name,overwrite):
		config.set_value(player_name,key_name,fxaa_is_activ)

func set_msaa_mode(msaa_mode:String,overwrite:bool=false)-> void:
	var key_name = options.msaa_mode
	if check_if_key_value_should_be_overwritten(key_name,overwrite):
		config.set_value(player_name,key_name,msaa_mode)

func set_master_volume(master_volume:float,overwrite:bool=false)-> void:
	var key_name = options.master_volume
	if check_if_key_value_should_be_overwritten(key_name,overwrite):
		config.set_value(player_name,key_name,master_volume)

func set_music_volume(music_volume:float,overwrite:bool=false)-> void:
	var key_name = options.music_volume
	if check_if_key_value_should_be_overwritten(key_name,overwrite):
		config.set_value(player_name,key_name,music_volume)


func set_effect_volume(effect_volume:float,overwrite:bool=false)-> void:
	var key_name = options.effect_volume
	if check_if_key_value_should_be_overwritten(key_name,overwrite):
		config.set_value(player_name,key_name,effect_volume)
	
	

	
func get_window_resolution()-> String:
	 return config.get_value(player_name,options.window_resolution)

func get_window_resizable()->bool:
	return config.get_value(player_name,options.window_resizable)

func get_fullscreen_is_activ()-> bool:
	 return config.get_value(player_name,options.fullscreen_is_activ)

func get_vsync_is_activ()-> bool:
	return config.get_value(player_name,options.vsync_is_activ)

func get_fxaa_is_activ()-> bool:
	return config.get_value(player_name,options.fxaa_is_activ)

func get_msaa_mode()-> String: 
	return config.get_value(player_name,options.msaa_mode)

func get_master_volume()-> float:
	return config.get_value(player_name,options.master_volume)

func get_music_volume()-> float:
	return config.get_value(player_name,options.music_volume)

func get_effect_volume()-> float:
	return config.get_value(player_name,options.effect_volume)

	

func save_config()-> void:
	config.save(config_filepath)
