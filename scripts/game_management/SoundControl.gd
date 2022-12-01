extends Node

const MASTER_BUS = 0
const MUSIC_BUS = 1
const SOUND_EFFECTS_BUS = 2


func _ready():
	AudioServer.set_bus_volume_db(MASTER_BUS,ConfigControl.get_master_volume())
	AudioServer.set_bus_volume_db(MUSIC_BUS,ConfigControl.get_music_volume())
	AudioServer.set_bus_volume_db(SOUND_EFFECTS_BUS,ConfigControl.get_effect_volume())


func update_master_volume(master_volume:float)->void:
	AudioServer.set_bus_volume_db(MASTER_BUS,master_volume)
	ConfigControl.set_master_volume(master_volume,true)
	ConfigControl.save_config()

func update_music_volume(music_volume:float)->void:
	AudioServer.set_bus_volume_db(MASTER_BUS,music_volume)
	ConfigControl.set_music_volume(music_volume,true)
	ConfigControl.save_config()

func update_effect_volume(effect_volume:float)->void:
	AudioServer.set_bus_volume_db(MASTER_BUS,effect_volume)
	ConfigControl.set_effect_volume(effect_volume,true)
	ConfigControl.save_config()
