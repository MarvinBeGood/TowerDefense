extends Node

class_name LevelInterface

class Level:
	var level: int
	var experince: int
	var reaserach_points: int
	
	func _init(level:int,
	experince:float,
	reaserach_points:int) -> void:
		self.level = level
		self.experince = experince
		self.reaserach_points = reaserach_points

var all_level = [
	Level.new(0,1000,1),
	Level.new(1,1000,1),
	Level.new(2,1000,1),
	Level.new(3,1000,1),
	Level.new(4,1000,1),
	Level.new(5,1000,2),
	Level.new(6,1000,1),
	Level.new(7,1000,1),
	Level.new(8,1000,1),
	Level.new(9,1000,1),
	Level.new(10,1000,2)]		



func get_all_level()->Array:
	return all_level

func get_level_by_number(level_number:int)->LevelInterface.Level:
	var selected_level 
	for level in all_level:
		if level.level == level_number:
			selected_level = level
		
	return selected_level	
