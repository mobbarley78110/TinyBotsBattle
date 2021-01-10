extends Area2D


func _ready():
	print('fucking ready to click')
 
func _input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print('clicked')
