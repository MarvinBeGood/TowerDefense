extends Node2D
class_name Tower

var is_build = false
var tower_price 
var tower_range 
var tower_damage
var tower_attack_speed
var collision_shape_name = "RangeCollisionShape"
var shootable_enemies = []
var area_2d := Area2D.new()
var area_2d_name = "EnemyDetection"
var collision_shape_2d := CollisionShape2D.new()
var circle_shape_2d := CircleShape2D.new()
var enemy_node_name = "KinematicBody2D"
var can_fire = true
var enemy 


func _ready():
	if is_build:
		area_2d.set_name(area_2d_name)
		area_2d.connect("body_entered",self,"mark_enemy_as_shootable")
		area_2d.connect("body_exited",self,"mark_enemy_as_non_shootable")
		circle_shape_2d.radius = get_tower_range() * 0.5
		collision_shape_2d.set_name(collision_shape_name)
		collision_shape_2d.shape = circle_shape_2d
		collision_shape_2d.position = Vector2(32,32)
		area_2d.add_child(collision_shape_2d)
		add_child(area_2d)


func mark_enemy_as_shootable(enemy:Node):
	if enemy.get_name()  == enemy_node_name:
		shootable_enemies.append(enemy.get_parent())

func mark_enemy_as_non_shootable(enemy:Node):
	if enemy.get_name() == enemy_node_name:
		shootable_enemies.erase(enemy.get_parent())


func _physics_process(_delta):
	if shootable_enemies.size() != 0 and is_build:
		selelect_enemy()
		turn()
		if can_fire:
			fire()
	else:
		enemy = null

func selelect_enemy():
	var offset_of_enemies = []
	for enemy in shootable_enemies:
		offset_of_enemies.append(enemy.offset)
	
	var enemy_with_max_offset = offset_of_enemies.max()
	var enemy_index = shootable_enemies.find(enemy_with_max_offset)
	enemy = shootable_enemies[enemy_index]

func fire():
	can_fire = false
	enemy.recive_damage(tower_damage)
	yield(get_tree().create_timer(tower_attack_speed),"timeout")
	can_fire = true


func turn():
	get_node("TowerCannonSprite").look_at(enemy.global_position)
	
	
func get_tower_price():
	return tower_price
	
func get_tower_range():
	return tower_range 

func get_tower_damage():
	return tower_damage

func get_tower_attack_speed():
	return tower_attack_speed

	
func set_tower_price(new_tower_price):
	tower_price = new_tower_price
	
func set_tower_range(new_tower_range):
	var collision_shape : CollisionShape2D = self.get_node(area_2d_name+"/"+collision_shape_name)
	collision_shape.get_shape().radius = new_tower_range * 0.5
	tower_range = new_tower_range 

func set_tower_damage(new_tower_damage):
	tower_damage = new_tower_damage

func set_tower_attack_speed(new_tower_attack_speed):
	tower_attack_speed = new_tower_attack_speed
