extends AnimatedSprite


func _ready():
	set_playing(true)
	connect("animation_finished",self,"remove_animation")

func remove_animation():
	queue_free()
