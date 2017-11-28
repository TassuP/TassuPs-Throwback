extends Node

func _input(event):
	if event is InputEventKey:
		if(event.get_scancode() == KEY_ESCAPE):
			get_tree().quit()
