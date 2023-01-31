extends CanvasLayer

onready var archer_tower_texture_button = $HUDControl/BuildBarVBoxContainer/GridContainer/ArcherTower

onready var dual_cannon_tower_texture_button = $HUDControl/BuildBarVBoxContainer/GridContainer/DualTower

onready var missile_cannon_tower_texture_button = $HUDControl/BuildBarVBoxContainer/GridContainer/MissileTower

onready var pause_play_texture_button = $HUDControl/GameControlHBoxContainer/PausePlayTextureButton

onready var speed_up_texture_button =  $HUDControl/GameControlHBoxContainer/SpeedUpTextureButton

onready var gold_amount_label = $HUDControl/InfoBarColorRect/HBoxContainer/GoldAmountLabel

onready var health_texture_progress = $HUDControl/InfoBarColorRect/HBoxContainer/HealthTextureProgress

onready var health_texture_progress_tween = $HUDControl/InfoBarColorRect/HBoxContainer/HealthTextureProgress/Tween

func _ready():

	archer_tower_texture_button.add_to_group("build_buttons")
	dual_cannon_tower_texture_button.add_to_group("build_buttons")
	missile_cannon_tower_texture_button.add_to_group("build_buttons")
	pause_play_texture_button.connect("pressed",self,"_on_pause_play_button_pressed")
	pause_play_texture_button.pause_mode = Node.PAUSE_MODE_PROCESS
	speed_up_texture_button.connect("pressed",self,"_on_speed_up_button_pressed")
	

func set_tower_preview(tower_type,mouse_position):
	var selected_tower :Node2D = load("res://scenes/towers/"+ tower_type +".tscn").instance()
	selected_tower.set_name("DragTower")
	selected_tower.modulate = Color("ad54ff3c")
	
	var range_texture = Sprite.new()
	range_texture.position = Vector2(32,32)
	var scaling = selected_tower.get_tower_range() / 600.0
	range_texture.scale = Vector2(scaling,scaling)
	range_texture.texture = load("res://images/towers/range_overlay.png")
	range_texture.modulate = Color("ad54ff3c")
	
	var control = Control.new()
	control.add_child(selected_tower,true)
	control.add_child(range_texture,true)
	control.rect_position = mouse_position
	control.set_name("TowerPreview")
	add_child(control,true)
	move_child(get_node("TowerPreview"),0)

func update_tower_preview(new_position,color):
	get_node("TowerPreview").rect_position = new_position
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/Sprite").modulate = Color(color)


func update_gold_amount(new_gold_amount:int):
	gold_amount_label.text = str(new_gold_amount)

func set_health_bar_max_health(max_health:int):
	health_texture_progress.value = max_health
	health_texture_progress.max_value = max_health

func update_health_bar(new_health:int):
	
	health_texture_progress_tween.interpolate_property(
	health_texture_progress, # node
	"value", # attribute
	health_texture_progress.value, # start_value
	new_health, # end_value
	0.1, # duration
	Tween.TRANS_LINEAR, # transition_type
	Tween.EASE_IN_OUT	# easing_type
	)
	health_texture_progress_tween.start()
	if new_health >= health_texture_progress.max_value/2:
		health_texture_progress.set_tint_progress(Color("3cc510"))
	elif new_health <= health_texture_progress.max_value/2 and new_health >= health_texture_progress.max_value/4:
		health_texture_progress.set_tint_progress(Color("e1be32"))
	else:
		health_texture_progress.set_tint_progress(Color("e11e1e"))
## 
## Game Controll functions
##

func _on_pause_play_button_pressed():
	if get_parent().build_mode:
		get_parent().cancle_build_mode()
	
	if get_tree().is_paused():
		get_tree().paused = false
	elif get_parent().current_wave == 0:
		get_parent().spawn_waves()
	else:
		get_tree().paused = true

func _on_speed_up_button_pressed():
	if get_parent().build_mode:
		get_parent().cancle_build_mode()
	
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(2.0)
