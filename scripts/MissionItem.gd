extends Node

var mission_information : MissionInterface.Mission

onready var level_name_label = $LevelNameLabel
onready var amount_of_enemies_lable = $HBoxContainer/GridContainer/AmountOfEnemiesLabel
onready var amount_of_experiences_lable =  $HBoxContainer/GridContainer/AmountOfExperiencesLabel
onready var difficulty_option_button =   $HBoxContainer/GridContainer/DifficultyOptionButton
onready var play_button = $PlayButton

var current_difficulty
signal play_button_pressed

func _ready():
	level_name_label.text = mission_information.mission_name
	set_difficulties()
	amount_of_enemies_lable.text = "Amount of Enemys: "+str(mission_information.calculate_ammount_of_enemys(current_difficulty))
	amount_of_experiences_lable.text = "Experiences: "+str(mission_information.calculate_received_experience_for_all_waves(current_difficulty))
	play_button.connect("pressed",self,"emiit_play_button_pressed")

func set_difficulties():
	var index = 0
	current_difficulty = mission_information.difficulties[0]
	for difficulty in mission_information.difficulties:
		difficulty_option_button.add_item(difficulty,index)
		if difficulty == current_difficulty:
			difficulty_option_button._select_int(index)
		
		index += 1

func emiit_play_button_pressed():
	emit_signal("play_button_pressed",mission_information,current_difficulty)
