extends CenterContainer

var profile: ProfileInterface.Profile

signal delete_profile_button_pressed
signal play_with_profile_button_pressed

func _ready():
	set_profile_name()
	set_profile_level()
	set_profile_amount_of_xp_to_next_level()



func set_profile_name():
	$VBoxContainer/CenterGrid/ProfileNameLabel.text = profile.profile_name

func set_profile_level():
	$VBoxContainer/CenterGrid/ProfileLevelLable.text = str(profile.profile_level)

func set_profile_amount_of_xp_to_next_level():
	print(profile.return_current_and_max_experience())
	$VBoxContainer/CenterGrid/ProfileAmountOfXPToNextLevelLable.text = profile.return_current_and_max_experience()

func _on_DeleteProfileButton_pressed():
	emit_signal("delete_profile_button_pressed",profile)
	


func _on_PlayWithProfileButton_pressed():
	emit_signal("play_with_profile_button_pressed",profile)
