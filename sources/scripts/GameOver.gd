extends Node

func _ready():
	AudioServer.set_bus_volume_db(0, 0.0)
	

func _input(event):
	if event is InputEventKey:
		if(event.get_scancode() == KEY_ESCAPE):
			get_tree().quit()
