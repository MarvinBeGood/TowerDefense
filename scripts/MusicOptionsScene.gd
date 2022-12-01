extends HBoxContainer

onready var MasterVolumeSlider = $MusicOptionsVBoxContainer/MasterVolumeHBoxContainer/MasterVolumeSlider
onready var MusicVolumeSlider = $MusicOptionsVBoxContainer/MusicVolumeHBoxContainer/MusicVolumeSlider
onready var EffectVolumeSlider = $MusicOptionsVBoxContainer/EffectVolumeHBoxContainer/EffectVolumeSlider

func _ready():
	MasterVolumeSlider.value = ConfigControl.get_master_volume()
	MusicVolumeSlider.value = ConfigControl.get_music_volume()
	EffectVolumeSlider.value = ConfigControl.get_effect_volume()
	


func _on_MasterVolumeSlider_value_changed(value):
	SoundControl.update_master_volume(value)


func _on_MusicVolumeSlider_value_changed(value):
	SoundControl.update_music_volume(value)


func _on_EffectVolumeSlider_value_changed(value):
	SoundControl.update_effect_volume(value)
