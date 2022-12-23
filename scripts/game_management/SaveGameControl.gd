extends Node

var save_data = {}


const savegame_filepath = "user://savegame.json"


func _ready():
	save_data = read_file()

func read_file():
	var file = File.new()
	if ! file.file_exists(savegame_filepath):
		save_data = {"player_name":"player"}
		save_game()
	file.open(savegame_filepath,File.READ)
	var file_content = file.get_as_text()
	var data = parse_json(file_content)
	save_data = data
	file.close()
	
	return(data)

func save_game():
	var save_game = File.new()
	save_game.open(savegame_filepath,File.WRITE)
	save_game.store_line(to_json(save_data))
