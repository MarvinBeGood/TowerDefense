extends PathFollow2D

var enemy : EnemyInterface.Enemy
var impact_area : NodePath
var collision_shape_2d : NodePath
var area_2d : NodePath
var health_bar = TextureProgress.new()
var projectile_impact = preload("res://scenes/enemies/effects/ProjectileImpact.tscn")
onready var collision_shape_2d_node = get_node(collision_shape_2d)
onready var area_2d_node = get_node(area_2d)
signal has_reached_the_end
signal was_killed

func _ready():
	area_2d_node.add_to_group("enemy")
	area_2d_node.connect("area_entered",self,"recive_damage")
	health_bar.nine_patch_stretch = true
	health_bar.texture_under = load("res://images/enemies/HPbar.jpg")
	health_bar.texture_progress = load("res://images/enemies/HPbar.jpg")
	health_bar.min_value = 0
	health_bar.value = enemy.enemy_health
	health_bar.max_value = enemy.enemy_health
	health_bar.tint_under = Color("2d2727")
	health_bar.tint_over = Color("ffffff")
	health_bar.tint_progress = Color("10b61f")
	health_bar.rect_position = Vector2(-collision_shape_2d_node.shape.radius*2,-20)
	health_bar.rect_size = Vector2(30,6)
	add_child(health_bar)

func _physics_process(delta):
	move(delta)

func move(delta):
	set_offset(get_offset() + enemy.enemy_movement_speed * delta)
	if get_unit_offset() >= 1.0:
		emit_signal("has_reached_the_end",enemy.enemy_damage)
		self.queue_free()

func impact():

	randomize()
	var x_position = randi() % int(collision_shape_2d_node.shape.radius * 2)
	randomize()
	var y_position = randi() % int((collision_shape_2d_node.shape.radius * 2) + collision_shape_2d_node.shape.height)
	var impact_location = Vector2(x_position,y_position)
	var new_impact = projectile_impact.instance()
	new_impact.position = impact_location
	get_node(impact_area).add_child(new_impact)
	
	
	
func recive_damage(area:Area2D):
	if area.is_in_group("projectile"):
		enemy.enemy_health -= area.damage
		health_bar.value = enemy.enemy_health
		if enemy.enemy_health <= 0:
			emit_signal("was_killed",enemy.enemy_worth)
			self.queue_free()
