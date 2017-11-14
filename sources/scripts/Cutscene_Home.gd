extends Node

export var done = false

func _process(delta):
	if(done):
		get_tree().change_scene("Cutscene_Home.tscn")
func skip():
	get_tree().change_scene("Dungeon.tscn")

func _input(event):
	if event is InputEventKey:
		if(event.get_scancode() == KEY_ESCAPE):
			skip()
#	if event is InputEventMouseButton:
#		start_game()
