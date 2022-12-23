extends PathFollow2D

var enemy_movement_speed
var enemy_health
var health_bar = TextureProgress.new()

func _ready():
	health_bar.nine_patch_stretch = true
	health_bar.texture_under = load("res://images/enemies/HPbar.jpg")
	health_bar.texture_progress = load("res://images/enemies/HPbar.jpg")
	health_bar.min_value = 0
	health_bar.value = enemy_health
	health_bar.max_value = enemy_health
	health_bar.tint_under = Color("2d2727")
	health_bar.tint_over = Color("ffffff")
	health_bar.tint_progress = Color("10b61f")
	health_bar.rect_position = Vector2(-30,-30)
	health_bar.rect_size = Vector2(30,6)
	add_child(health_bar)
	
	
func _physics_process(delta):
	move(delta)

func move(delta):
	set_offset(get_offset() + enemy_movement_speed * delta)
	# needs to be set if the enemy is rotating 
	#health_bar.set_position(position - Vector2(30,30))

func recive_damage(damage:int):
	print(enemy_health)
	enemy_health -= damage
	health_bar.value = enemy_health
	if enemy_health <= 0:
		die()
		
func die():
	self.queue_free()

func set_enemy_movement_speed(new_enemy_movement_speed):
	enemy_movement_speed = new_enemy_movement_speed

func set_enemy_health(new_enemy_health):
	enemy_movement_speed = new_enemy_health
	
func get_enemy_movement_speed():
	return enemy_movement_speed

func get_enemy_health():
	return enemy_health 
