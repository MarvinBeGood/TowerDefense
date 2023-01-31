extends Node2D
class_name Tower

var is_build = false
var tower_name 
var tower_price 
var tower_range 
var tower_damage
var tower_attack_speed :float
var collision_shape_name = "RangeCollisionShape"
var shootable_enemies = []
var area_2d := Area2D.new()
var area_2d_name = "EnemyDetection"
var collision_shape_2d := CollisionShape2D.new()
var circle_shape_2d := CircleShape2D.new()
var enemy_node_name = "Area2D"
var arrow_spawn_position : NodePath
var can_fire = true
var enemy = null


func _ready():
	if is_build:
		area_2d.set_name(area_2d_name)
		area_2d.connect("area_entered",self,"mark_enemy_as_shootable")
		area_2d.connect("area_exited",self,"mark_enemy_as_non_shootable")
		circle_shape_2d.radius = get_tower_range() * 0.5
		collision_shape_2d.set_name(collision_shape_name)
		collision_shape_2d.shape = circle_shape_2d
		collision_shape_2d.position = Vector2(32,32)
		area_2d.add_child(collision_shape_2d)
		add_child(area_2d)


func mark_enemy_as_shootable(selected_enemy:Area2D):
	if selected_enemy.is_in_group("enemy"):
		shootable_enemies.append(selected_enemy.get_parent())

func mark_enemy_as_non_shootable(selected_enemy:Area2D):
	if selected_enemy.is_in_group("enemy"):
		var enemy_index = shootable_enemies.find(selected_enemy.get_parent())
		shootable_enemies.remove(enemy_index)


func _physics_process(_delta):
	if shootable_enemies.size() != 0 and is_build:
		selelect_enemy()
		#if not get_node("AnimationPlayer").is_playing():
		turn()
		if can_fire:
			fire()
	else:
		enemy = null

func selelect_enemy():
	enemy = shootable_enemies[0]

func fire():
	can_fire = false
	var arrow =  preload("res://scenes/towers/Arrow.tscn").instance()
	arrow.enemy = enemy
	arrow.damage = tower_damage
	get_node(arrow_spawn_position).add_child(arrow)
	yield(get_tree().create_timer(tower_attack_speed,false),"timeout")
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
