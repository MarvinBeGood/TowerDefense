extends Node
class_name EnemyDefaultValues



static func get_enemies()->Dictionary:
	var enemies: Dictionary = {"blue_little_guy":EnemyInterface.Enemy.new("blue_little_guy",
	50, 	# health
	100, 	# movement speed
	10, 	# experince 
	10, 	# worth
	1 		# damage
	)} 
	return enemies
