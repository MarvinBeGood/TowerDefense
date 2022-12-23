extends Control

onready var back_to_loadout_button = $VBoxContainer/BackButton

signal change_to_loadout

func _ready():
	back_to_loadout_button.connect("pressed",self,"change_to_loadout")
	

func change_to_loadout():
	emit_signal("change_to_loadout")
