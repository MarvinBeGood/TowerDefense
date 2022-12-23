extends Node2D

class_name ProfileInterface

class Profile:
	
	var profile_name:String
	var profile_level:int
	var current_amount_of_experience:int
	var experience_to_next_level:int
	
	func _init(profile_name:String,
					profile_level:int,
					current_amount_of_experience:int,
					experience_to_next_level:int
					):
			self.profile_name = profile_name
			self.profile_level = profile_level
			self.current_amount_of_experience = current_amount_of_experience
			self.experience_to_next_level = experience_to_next_level

	func as_dictionary()->Dictionary:
			var profil_data := {
				"profile_name":self.profile_name,
				"profile_level":self.profile_level,
				"current_amount_of_experience":self.current_amount_of_experience,
				"experience_to_next_level":self.experience_to_next_level
			}
			return profil_data

	func as_string()-> String:
		return """profile_name: {profile_name}\nprofile_level: {profile_level} \ncurrent_amount_of_experience: {current_amount_of_experience} \nexperience_to_next_level: {experience_to_next_level}""".format(self.as_dictionary())

	func return_current_and_max_experience()-> String:
		return str(self.current_amount_of_experience)+"/"+str(self.experience_to_next_level)

	static func create_profil_from_dict(data:Dictionary):
		return Profile.new(data.profile_name,
		data.profile_level,
		data.current_amount_of_experience,
		data.experience_to_next_level)
