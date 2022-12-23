extends Control

class_name LoadoutControl

onready var profile_name_label = $VBoxContainer/ProfileStatsHBoxContainer/ProfileNameRichTextLabel
onready var profile_level_label = $VBoxContainer/ProfileStatsHBoxContainer/ProfileLevelRichTextLabel
onready var profile_amount_of_xp_to_next_level_label = $VBoxContainer/ProfileStatsHBoxContainer/ProfileExperienceRichTextLabel
onready var to_mission_selection_button =  $VBoxContainer/HBoxContainer/GridContainer/SelectMissionButton
onready var to_techtree_button =  $VBoxContainer/HBoxContainer/GridContainer/TechtreeButton
onready var to_inventory_button =  $VBoxContainer/HBoxContainer/GridContainer/InventoryButton
onready var to_profile_selection_button =  $VBoxContainer/HBoxContainer/GridContainer/BackButton

var current_profile: ProfileInterface.Profile 

signal change_to_profil_selection
signal change_to_mission_selection
signal change_to_techtree
signal change_to_inventory

func _ready():
	profile_name_label.text = current_profile.profile_name
	profile_level_label.text = str(current_profile.profile_level)
	profile_amount_of_xp_to_next_level_label.text = current_profile.return_current_and_max_experience()
	to_mission_selection_button.connect("pressed",self,"change_to_mission_selection")
	to_techtree_button.connect("pressed",self,"change_to_techtree")
	to_inventory_button.connect("pressed",self,"change_to_inventory")
	to_profile_selection_button.connect("pressed",self,"change_to_profile_selection")

	
func change_to_mission_selection():
	emit_signal("change_to_mission_selection")

func change_to_techtree():
	emit_signal("change_to_techtree")

func change_to_inventory():
	emit_signal("change_to_inventory")
	
func change_to_profile_selection():
	emit_signal("change_to_profil_selection")
