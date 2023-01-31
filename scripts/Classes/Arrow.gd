extends Area2D

var speed: int = 20
var enemy
var damage
var look_vector = Vector2.ZERO
var move = Vector2.ZERO

onready var visibility_notifier_2d = $VisibilityNotifier2D

func _ready() -> void:
	add_to_group("projectile")
	visibility_notifier_2d.connect("screen_exited",self,"on_screen_exited")
	if enemy != null:
		$ArrowSprite.look_at(enemy.global_position)
		look_vector = enemy.global_position - global_position

func _physics_process(delta: float) -> void:
	move = Vector2.ZERO
	move = move.move_toward(look_vector,delta)
	move = move.normalized() * speed
	
	global_position += move

func on_screen_exited()-> void:
	self.queue_free()

func destroy(_area:Area2D)-> void:
	self.queue_free()

