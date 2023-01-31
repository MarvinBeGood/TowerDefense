extends Node2D

class_name MissionInterface

class EnemyWavesDifficultyMapping:
	var enemy_waves: Array
	var difficulty: String
	
	func _init(enemy_waves:Array,difficulty:String) -> void:
		self.enemy_waves = enemy_waves
		self.difficulty = difficulty
	
	func as_string()-> String:
		var output = ""
		for wave in enemy_waves:
			output += "wave_number: "+ str(wave.wave_number) + "\n"
			for enemy in wave.enemies:
				output += "enemy_name: "+ enemy.enemy_name + "amount: "+ str(enemy.amount_of_enemies) +"\n"
			
		output += "difficulty: "+ difficulty
		return output
	
	func get_class():
		return "EnemyWavesDifficultyMapping"

class Mission:
	
	var mission_name:String
	var base_health: int
	var start_gold: int
	var enemy_waves_mapping_to_difficulty: Array
	var difficulties : Array

	func _init(mission_name:String,
	base_health:int,
	start_gold:int,
	enemy_waves_mapping_to_difficulty:Array):
			self.mission_name = mission_name
			self.base_health = base_health
			self.start_gold = start_gold
			self.enemy_waves_mapping_to_difficulty = enemy_waves_mapping_to_difficulty
			get_all_difficulties()
			
	func as_dictionary()->Dictionary:
			var level_data := {
				"mission_name":self.mission_name,
				"base_health": self.base_health,
				"start_gold":self.start_gold,
				"enemy_waves_mapping_to_difficulty":self.enemy_waves_mapping_to_difficulty,
				"difficulties": self.difficulties
			}
			return level_data
	
	func get_all_difficulties():
		var current_difficulties = []
		for mapping in self.enemy_waves_mapping_to_difficulty:
			current_difficulties.append(mapping.difficulty)
		
		self.difficulties = current_difficulties
			
	
	func calculate_ammount_of_enemys(difficulty:String):
		var enemy_counter = 0
		
		for mapping in self.enemy_waves_mapping_to_difficulty:
			if mapping.difficulty == difficulty:
				for wave in mapping.enemy_waves:
					for enemy in wave.enemies:
						enemy_counter += enemy.amount_of_enemies
				
		return enemy_counter

	
	func calculate_received_experience_for_all_waves(difficulty:String):
		var experience = 0
		for mapping in self.enemy_waves_mapping_to_difficulty:
			if mapping.difficulty == difficulty:
				for wave in mapping.enemy_waves:
					for enemy in wave.enemies:
						if difficulty == "easy":
							experience += EnemyDefaultValues.get_enemies().get(enemy.enemy_name).get_enemy_experience() * enemy.amount_of_enemies
					
		return experience
	
	func get_enemy_waves_for_difficulty(difficulty:String):
		for mapping in self.enemy_waves_mapping_to_difficulty:
			if mapping.difficulty == difficulty:
				return mapping.enemy_waves 


	func change_enemies_on_difficulty(difficulty:String):
		pass
	
	

	func as_string()-> String:
		var output = ""
		output += "mission_name: " +  mission_name + " \n"
		output += "enemy_waves_mapping_to_difficulty: \n" 
		for mapping in enemy_waves_mapping_to_difficulty:
			output += mapping.as_string()
		return output

	static func create_level_from_dict(data:Dictionary):
		return Mission.new(
		data.mission_name,
		data.base_health,
		data.start_gold,
		data.enemy_waves_mapping_to_difficulty)

	func get_class():
		return "Mission"
