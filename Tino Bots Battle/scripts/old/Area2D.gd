extends Area2D


func _ready():
	print('ready')

	
func _on_Clickable_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		print('clicked')
