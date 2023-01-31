extends Control

onready var back_to_loadout_button = $VBoxContainer/BackButton
onready var missions_vbox_container = $VBoxContainer/HBoxContainer/ScrollContainer/MissionsVBoxContainer
signal change_to_loadout
signal change_to_mission

func _ready():
	back_to_loadout_button.connect("pressed",self,"change_to_loadout")
	

	var available_maps = [tutorial_map.get_mission_information()]
	for map in available_maps:
		var mission_item = preload("res://scenes/ui/MissionItem.tscn").instance()
		mission_item.mission_information = map
		mission_item.connect("play_button_pressed",self,"change_to_mission")
		missions_vbox_container.add_child(mission_item)
	

func change_to_loadout():
	emit_signal("change_to_loadout")

func change_to_mission(mission_information,current_difficulty):
	emit_signal("change_to_mission",mission_information,current_difficulty)
