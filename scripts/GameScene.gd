extends Node2D


var build_mode = false
var build_valid = false
var build_tile 
var build_location 
var build_type
var start_position 
var end_position
var enemies_in_wave 
var current_wave = 0
var map_node
var mission_information : MissionInterface.Mission
var current_difficulty 
var base_health
var current_gold

func _ready():
	map_node = load("res://scenes/maps/"+mission_information.mission_name+".tscn").instance()
	add_child(map_node)
	for build_button in get_tree().get_nodes_in_group("build_buttons"):
		build_button.connect("pressed",self,"initiate_build_mode",[build_button.get_name()])
	base_health = mission_information.base_health
	current_gold = mission_information.start_gold
	get_node("UICanvasLayer").set_health_bar_max_health(base_health)
	get_node("UICanvasLayer").update_health_bar(base_health)
	get_node("UICanvasLayer").update_gold_amount(current_gold)
	

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
		

# wave system
func spawn_waves():
		for mapping in mission_information.enemy_waves_mapping_to_difficulty:
			if mapping.difficulty == current_difficulty:
				for wave in mapping.enemy_waves:
					if wave.wave_number >= 2:
						yield(get_tree().create_timer(wave.time_between_wave,false),"timeout")
						
					current_wave = wave.wave_number
					for enemy in wave.enemies:
						for _amount in range(enemy.amount_of_enemies):
							var new_enemy = load("res://scenes/enemies/"+enemy.enemy_name+ ".tscn").instance()
							new_enemy.enemy = EnemyDefaultValues.get_enemies().get(enemy.enemy_name)
							new_enemy.connect("has_reached_the_end",self,"receive_damage")
							new_enemy.connect("was_killed",self,"receive_gold")
							map_node.get_node("Path2D").add_child(new_enemy,true)
							yield(get_tree().create_timer(wave.time_between_enemy,false),"timeout")


func receive_damage(damage:int):
	base_health -= damage
	get_node("UICanvasLayer").update_health_bar(base_health)
	if base_health <= 0:
		emit_signal("game_over",false)

	
	
func receive_gold(gold:int):
	current_gold += gold
	get_node("UICanvasLayer").update_gold_amount(current_gold)
