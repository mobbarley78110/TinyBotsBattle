extends Area2D

onready var main = get_tree().get_current_scene()
onready var this_character = get_parent()

func _ready():
	pass

func _input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT):
		#main.select_unit(get_parent()) # sent Character to the select_unit() function in Game
		main.select_unit(this_character)

