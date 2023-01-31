extends Node




const profiles_filepath = "user://profiles.tres"
var save_data = {}
var profiles_file = File.new()
var profiles_as_objects = []

func _ready():
	save_data = read_file()
	profiles_as_objects = get_profiles()


func read_file()->Dictionary:
	if ! profiles_file.file_exists(profiles_filepath):
		save_data = {"profiles": []}
		save_game()
	profiles_file.open(profiles_filepath,File.READ)
	var file_content = profiles_file.get_as_text()
	var data = parse_json(file_content)
	profiles_file.close()
	
	return data

func save_game()->void:
	
	var save_game = File.new()
	save_data.profiles = convert_profiles_to_dicts()
	save_game.open(profiles_filepath,File.WRITE)
	save_game.store_line(JSON.print(save_data, "\t"))

func convert_profiles_to_dicts()->Array:
	var profiles_as_dicts = []
	for profil_object in profiles_as_objects:
		profiles_as_dicts.append(profil_object.as_dictionary())
	return profiles_as_dicts

func get_profiles()->Array:
	var profil_objects = []
	var profiles_as_dicts = save_data.get("profiles")
	for profile in profiles_as_dicts:
		profil_objects.append(ProfileInterface.Profile.create_profil_from_dict(profile))
	
	return profil_objects



func add_profile(profile:ProfileInterface.Profile)->void:
	profiles_as_objects.append(profile)
	save_game()


func change_profile(profile:ProfileInterface.Profile)-> void:
	profiles_as_objects = get_profiles()
	var new_profile_objects = []
	for profil_object in profiles_as_objects:
		if profil_object.profil_name == profile.profil_name:
			profil_object = profile
		new_profile_objects.append(profil_object)
	profiles_as_objects = new_profile_objects
	save_game()
	

func get_profile_by_profile_name(profile_name:String)->ProfileInterface.Profile:
	profiles_as_objects = get_profiles()

	var selected_profile_object 
	for profile_object in profiles_as_objects:
		if profile_object.profile_name == profile_name:
			selected_profile_object = profile_object
	return selected_profile_object

func delete_profile_by_profile_name(profile_name:String)->void:
	profiles_as_objects = get_profiles()
	var index = 0
	
	for profile_object in profiles_as_objects:
		if profile_object.profile_name == profile_name:
			profiles_as_objects.remove(index)
		index += 1
	save_game()

func get_all_profile_names()-> Array:
	profiles_as_objects = get_profiles()
	var profile_names = []
	for profile_object in profiles_as_objects:
		profile_names.append(profile_object.profile_name)
	return profile_names

func check_if_profile_exists(profile_name:String)->bool:
	var profile_names = get_all_profile_names()
	return profile_names.has(profile_name)
