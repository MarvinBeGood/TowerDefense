extends Node

class_name WaveInterface

class EnemyContainer:
	var enemy_name: String
	var amount_of_enemies: int
	
	func _init(enemy_name:String,
		amount_of_enemies:int) -> void:
		self.enemy_name = enemy_name
		self.amount_of_enemies = amount_of_enemies
	
	func get_class():
		return "EnemyContainer"

	
class Wave:
	var wave_number: int
	var enemies: Array
	var time_between_enemy: float
	var time_between_wave: float
	
	func _init(wave_number: int,
			enemies:Array,
			time_between_enemy:float,
			time_between_wave: float
			) -> void:
			
			self.wave_number = wave_number
			self.enemies = enemies
			self.time_between_enemy = time_between_enemy
			self.time_between_wave = time_between_wave

	func get_class():
		return "Wave"
		

