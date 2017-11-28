extends Node

export var done = false

func _process(delta):
	if(done):
		get_tree().change_scene("GameOver.tscn")
