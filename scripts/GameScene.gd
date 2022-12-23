extends Node2D

var map_node 
var build_mode = false
var build_valid = false
var build_tile 
var build_location 
var build_type
var start_position 
var end_position
var enemies_in_wave 
var current_wave = 0



func _ready():

	
	map_node = get_node("Map1")
	for build_button in get_tree().get_nodes_in_group("build_buttons"):
		build_button.connect("pressed",self,"initiate_build_mode",[build_button.get_name()])


func initiate_build_mode(tower_type):
	if build_mode:
		cancle_build_mode()
	build_type = tower_type
	build_mode = true
	get_node("UICanvasLayer").set_tower_preview(build_type,get_global_mouse_position())


func _process(_delta):
	if build_mode:
		update_tower_preview()
		
func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusionTileMap").world_to_map(mouse_position)
	var tile_postiton =  map_node.get_node("TowerExclusionTileMap").map_to_world(current_tile) 
	
	if map_node.get_node("TowerExclusionTileMap").get_cellv(current_tile) == -1:
		get_node("UICanvasLayer").update_tower_preview(tile_postiton,"ad54ff3c")
		build_valid = true
		build_location = tile_postiton
		build_tile = current_tile
		
	else:
		get_node("UICanvasLayer").update_tower_preview(tile_postiton,"adff4545")
		
		build_valid = false


func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancle_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancle_build_mode()

func cancle_build_mode():
	build_mode = false
	build_valid = false
	get_node("UICanvasLayer/TowerPreview").free()

func verify_and_build():
	if build_valid:
		var new_tower = load("res://scenes/towers/"+ build_type +".tscn").instance()
		new_tower.position = build_location
		new_tower.is_build = true
		map_node.get_node("TowerInstancesNode2D").add_child(new_tower,true)
		map_node.get_node("TowerExclusionTileMap").set_cellv(build_tile,6)
		

func start_next_wave():
	var wave_data = retrive_wave_data()
	yield(get_tree().create_timer(0.2),"timeout")
	spawn_enemies(wave_data)
	
	
func retrive_wave_data():
	var wave_data = [["Enemy1",0.6],["Enemy1",0.1]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data
	
func spawn_enemies(wave_data):
	for enemy in wave_data:
		var new_enemy = load("res://scenes/enemies/"+enemy[0]+ ".tscn").instance()
		map_node.get_node("Path2D").add_child(new_enemy,true)
		yield(get_tree().create_timer(enemy[1]),"timeout")
