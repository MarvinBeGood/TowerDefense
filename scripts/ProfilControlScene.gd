extends Control

onready var profiles_vbox_container = $VBoxContainer
onready var profile_creation_panel = $ProfileCreationPanel
onready var profile_name_line_edit = $ProfileCreationPanel/VBoxContainer/HBoxContainer/NewProfileNameLineEdit
onready var profile_vbox_container = $VBoxContainer/ProfileCenterContainer/ProfileVBoxContainer

onready var notice_panel = $NoticePanel
onready var notice_lable = $NoticePanel/VBoxContainer/NoticeTextLabel

onready var delete_profile_panel =  $DeleteProfilePanel
onready var delete_profile_lable = $DeleteProfilePanel/VBoxContainer/NoticeDeleteProfileTextLabel

onready var open_profile_creation_panel_button = $VBoxContainer/ButtonCenterContainer/ButtonGridContainer/CreateNewProfileButton
onready var create_new_profile_button =  $ProfileCreationPanel/VBoxContainer/HBoxContainer2/CreateNewProfileButton
onready var close_new_profie_popup_button = $ProfileCreationPanel/VBoxContainer/HBoxContainer3/ClosePopupButton
onready var close_notice_popup_button = $NoticePanel/VBoxContainer/CloseButton

onready var accept_delete_profile_button = $DeleteProfilePanel/VBoxContainer/HBoxContainer/AcceptDeleteProfileButton
onready var close_delete_profile_button = $DeleteProfilePanel/VBoxContainer/HBoxContainer/CloseDeleteProfilePanelButton

const profile_item_scene = "res://scenes/ui/ProfileItem.tscn"
var selected_profile:ProfileInterface.Profile


signal change_to_loadout_scene


func _ready():
	open_profile_creation_panel_button.connect("pressed",self,"on_open_profile_creation_button_pressed") 
	create_new_profile_button.connect("pressed",self,"on_create_new_profile_button_pressed")
	close_new_profie_popup_button.connect("pressed",self,"on_close_profile_creation_button_pressed")
	close_notice_popup_button.connect("pressed",self,"on_close_button_pressed")
	accept_delete_profile_button.connect("pressed",self,"on_accept_delete_profile_button_pressed")
	close_delete_profile_button.connect("pressed",self,"on_close_delete_profile_panel_button_pressed")
	
	for profile in ProfileSaveControl.get_profiles():
		var profile_item = preload(profile_item_scene).instance()
		
		profile_item.profile = profile
		profile_vbox_container.add_child(profile_item)
		profile_item.connect("delete_profile_button_pressed",self,"delete_profile")
		profile_item.connect("play_with_profile_button_pressed",self,"emit_change_to_loadout_scene")

func on_create_new_profile_button_pressed():
	var new_profile_name = profile_name_line_edit.text
	
	if ProfileSaveControl.check_if_profile_exists(new_profile_name):
		var text_message = "A profile with the name {profile_name} alread exists.".format({"profile_name":new_profile_name})
		notice_lable.text = text_message
		notice_panel.visible = true
	elif new_profile_name == "":
		var text_message = "The porfile name cannot be empty"
		notice_lable.text = text_message
		notice_panel.visible = true
	else:
		notice_lable.text = ""
		notice_panel.visible = false

		var profile_item = preload(profile_item_scene).instance()
		var new_profile = ProfileInterface.Profile.new(new_profile_name, 
		0, # profile_level
		0, # current_amount_of_experience
		LevelInterface.new().get_level_by_number(0).experince, #experience_to_next_level
		0, # research_points
		0) # prestige_points
		
		profile_item.profile = new_profile
		profile_item.connect("delete_profile_button_pressed",self,"delete_profile")
		profile_item.connect("play_with_profile_button_pressed",self,"emit_change_to_loadout_scene")
		profile_creation_panel.visible = false
		profiles_vbox_container.visible = true
		profile_vbox_container.add_child(profile_item)
		ProfileSaveControl.add_profile(new_profile)


func on_close_profile_creation_button_pressed():
	profiles_vbox_container.visible = true
	profile_creation_panel.visible = false


func on_open_profile_creation_button_pressed():
	profiles_vbox_container.visible = false
	profile_creation_panel.visible = true



func on_close_button_pressed():
	notice_panel.visible = false
	profile_creation_panel.visible = true

func emit_change_to_loadout_scene(profile:ProfileInterface.Profile):
	emit_signal("change_to_loadout_scene",profile)
	

func delete_profile(profile:ProfileInterface.Profile):
	profiles_vbox_container.visible = false
	selected_profile = profile
	var text_message = "Are you sure to delete profile with profile name {profile_name} ?".format({"profile_name":selected_profile.profile_name})
	delete_profile_lable.text = text_message
	delete_profile_panel.visible = true

func on_close_delete_profile_panel_button_pressed():
	profiles_vbox_container.visible = true
	delete_profile_panel.visible = false
	delete_profile_lable.text = ""
	selected_profile = null

func on_accept_delete_profile_button_pressed():
	for profile_node in profile_vbox_container.get_children():
		if profile_node.profile.profile_name == selected_profile.profile_name:
			profile_node.queue_free()
	ProfileSaveControl.delete_profile_by_profile_name(selected_profile.profile_name)
	delete_profile_panel.visible = false
	profiles_vbox_container.visible = true
