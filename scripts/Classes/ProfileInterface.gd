extends Node2D

class_name ProfileInterface

class Profile:
	
	var profile_name:String
	var profile_level:int
	var current_amount_of_experience:int
	var experience_to_next_level:int
	var research_points:int
	var prestige_points:int
	
	func _init(
			profile_name:String,
			profile_level:int,
			current_amount_of_experience:int,
			experience_to_next_level:int,
			research_points:int,
			prestige_points:int
			):
			
			self.profile_name = profile_name
			self.profile_level = profile_level
			self.current_amount_of_experience = current_amount_of_experience
			self.experience_to_next_level = experience_to_next_level
			self.research_points = research_points
			self.prestige_points = prestige_points

	func as_dictionary()->Dictionary:
			var profil_data := {
				"profile_name":self.profile_name,
				"profile_level":self.profile_level,
				"current_amount_of_experience":self.current_amount_of_experience,
				"experience_to_next_level":self.experience_to_next_level,
				"research_points":self.research_points,
				"prestige_points":self.prestige_points
			}
			return profil_data

	func as_string()-> String:
		return """profile_name: {profile_name}\nprofile_level: {profile_level} \n current_amount_of_experience: {current_amount_of_experience} \nexperience_to_next_level: {experience_to_next_level}\n research_points: {research_points}  \n prestige_points: {prestige_points}""".format(self.as_dictionary())

	func return_current_and_max_experience()-> String:
		return str(self.current_amount_of_experience)+"/"+str(self.experience_to_next_level)
	
	func calculate_experience_to_next_level()-> int:
		return self.experience_to_next_level - self.current_amount_of_experience
	
	
	func update_level_and_experience(experience:int)->void:
		while experience > 0:
			var experience_to_next_level = calculate_experience_to_next_level()
			var level_stats = LevelInterface.new().get_level_by_number(self.profile_level)
			
			if level_stats == null:
				self.profile_level = self.profile_level - 1
				self.current_amount_of_experience = 9999
				self.experience_to_next_level = 9999
				break
			
			if experience >= experience_to_next_level:
				self.profile_level += 1
				self.current_amount_of_experience = 0

				self.experience_to_next_level = level_stats.experince
				self.research_points += level_stats.reaserach_points
				experience = experience - experience_to_next_level
			else:
				self.current_amount_of_experience += experience
				experience -= experience
			
	
	static func create_profil_from_dict(data:Dictionary):
		var research_points = data.get("research_points")
		var prestige_points = data.get("prestige_points")
		if research_points == null:
			research_points = 0
		if prestige_points == null:
			prestige_points = 0
		
		return Profile.new(data.profile_name,
		data.profile_level,
		data.current_amount_of_experience,
		data.experience_to_next_level,
		research_points,
		prestige_points)
