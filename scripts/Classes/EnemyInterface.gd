extends Node

class_name EnemyInterface

class Enemy:
	
	var enemy_name:String
	var enemy_health: int
	var enemy_movement_speed: int
	var enemy_experience: int
	var enemy_worth: int
	var enemy_damage: int

	func _init(enemy_name:String,
			enemy_health:int,
			enemy_movement_speed:int,
			enemy_experience:int,
			enemy_worth:int,
			enemy_damage: int):
			
			self.enemy_name = enemy_name
			self.enemy_health = enemy_health
			self.enemy_movement_speed = enemy_movement_speed
			self.enemy_experience = enemy_experience
			self.enemy_worth = enemy_worth
			self.enemy_damage = enemy_damage
	
	func set_enemy_movement_speed(new_enemy_movement_speed):
		self.enemy_movement_speed = new_enemy_movement_speed

	func set_enemy_health(new_enemy_health):
		self.enemy_movement_speed = new_enemy_health
	
	func set_enemy_experience(new_enemy_experience):
		self.enemy_experience = new_enemy_experience
	
	func set_enemy_worth(new_enemy_worth):
		self.enemy_worth = new_enemy_worth
	
	func set_enemy_damage(new_enemy_damage):
		self.enemy_damage = new_enemy_damage
	
	func get_enemy_health():
		return self.enemy_health 
	
	func get_enemy_movement_speed():
		return self.enemy_movement_speed

	func get_enemy_experience():
		return self.enemy_experience
		
	func get_enemy_worth():
		return self.enemy_worth
	
	func get_enemy_damage():
		return self.enemy_damage
	
	func as_dictionary()->Dictionary:
			var enemy_data := {
				"enemy_name":self.enemy_name,
				"enemy_health":self.enemy_health,
				"enemy_movement_speed":self.enemy_movement_speed,
				"enemy_experience":self.enemy_experience,
				"enemy_worth":self.enemy_worth,
				"enemy_damage": self.enemy_damage
			}
			return enemy_data
	

	func as_string()-> String:
		return """enemy_name: {enemy_name} \n enemy_health:{enemy_health} \n enemy_movement_speed:{enemy_movement_speed} \n enemy_experience: {enemy_experience} \n enemy_worth: {enemy_worth} \n enemy_damage: {enemy_damage}""".format(self.as_dictionary())

	static func create_level_from_dict(data:Dictionary):
		return Enemy.new(data.level_name,
		data.enemy_health,
		data.enemy_movement_speed,
		data.enemy_experience,
		data.enemy_worth,
		data.enemy_damage)



