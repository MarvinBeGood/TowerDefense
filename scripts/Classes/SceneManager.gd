extends Node

var options_menu_scene = "res://scenes/ui/OptionsMenu.tscn"
var profile_control_scene = "res://scenes/ui/ProfileControlScene.tscn"
var main_scene = "res://scenes/main_scenes/SceneManager.tscn"



func _ready():
	get_node("MainMenu/VBoxContainer/HBoxContainer/GridContainer/PlayButton").connect("pressed",self,"on_play_button_pressed")
	get_node("MainMenu/VBoxContainer/HBoxContainer/GridContainer/OptionsButton").connect("pressed",self,"on_options_button_pressed")
	get_node("MainMenu/VBoxContainer/HBoxContainer/GridContainer/QuitButton").connect("pressed",self,"on_quit_button_pressed")
	get_node("OptionsMenu/PanelContainer/BackButton").connect("pressed",self,"on_options_back_button_pressed")
	get_node("ProfileControl/VBoxContainer/ButtonCenterContainer/ButtonGridContainer/BackButton").connect("pressed",self,"on_profile_back_button_pressed")
	get_node("ProfileControl").connect("change_to_loadout_scene",self,"update_loadout_scene")

func on_options_button_pressed():
	$OptionsMenu.visible = true
	$MainMenu.visible = false

func on_quit_button_pressed():
	get_tree().quit()

func on_play_button_pressed():
	$MainMenu.visible = false
	$ProfileControl.visible = true

func on_options_back_button_pressed():
	$MainMenu.visible = true
	$OptionsMenu.visible = false


func on_profile_back_button_pressed():
	$MainMenu.visible = true
	$ProfileControl.visible = false

func update_loadout_scene(profile:ProfileInterface.Profile):
	$ProfileControl.visible = false
	var loadout_scene_node :Node = preload("res://scenes/ui/LoadoutControlScene.tscn").instance()
	loadout_scene_node.current_profile = profile
	
	#if ! loadout_scene_node.is_connected("change_to_profil_selection",self,"on_loadout_back_button_pressed"):
	#loadout_scene_node.connect("change_to_techtree",self,"on_techtree_button_pressed")
	#loadout_scene_node.connect("change_to_inventory",self,"on_inventory_button_pressed")
	loadout_scene_node.connect("change_to_mission_selection",self,"on_mission_selection_button_pressed")
	loadout_scene_node.connect("change_to_profil_selection",self,"on_loadout_back_button_pressed")

	#if ! has_node("LoadoutControl"):
	add_child(loadout_scene_node,true)
	

func on_loadout_back_button_pressed():
	$ProfileControl.visible = true
	$LoadoutControl.queue_free()


func on_mission_selection_button_pressed():
	$LoadoutControl.visible = false
	var mission_selection_scene_node :Node = preload("res://scenes/ui/MissionSelectionControl.tscn").instance()
	mission_selection_scene_node.connect("change_to_loadout",self,"on_change_to_loadout_button_pressed")
	mission_selection_scene_node.connect("change_to_mission",self,"on_change_to_mission_button_pressed")
	add_child(mission_selection_scene_node,true)

func on_change_to_loadout_button_pressed():
	$LoadoutControl.visible = true
	$MissionSelectionControl.queue_free()

func on_change_to_mission_button_pressed(mission_information,current_difficulty):
	$MissionSelectionControl.queue_free()
	var game_scene = load("res://scenes/game_scenes/GameScene.tscn").instance()
	game_scene.mission_information = mission_information
	game_scene.current_difficulty = current_difficulty
	add_child(game_scene,true)
