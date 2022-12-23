extends HBoxContainer

onready var language_option_button = $LanguageOptionsVBoxContainer/LanguageHBoxContainer/LanguageOptionButton

func _ready():
	set_languages()

func set_languages():
	var index = 0
	var current_language = ConfigControl.get_language()
	
	for supported_languages in LanguageControl.supported_languages:
		language_option_button.add_item(supported_languages,index)
		if supported_languages == current_language:
			language_option_button._select_int(index)
		
		
		index += 1
