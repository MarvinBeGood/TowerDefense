extends Button


func _on_BackButton_pressed():
	var _is_valid_scene = get_tree().change_scene("res://scenes/MainMenu.tscn")
