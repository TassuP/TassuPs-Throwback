extends Node

var started = false
export var done = false

func start_game():
	if(started == false):
		Game.intro_started = true
		started = true
		var ap = get_node("AnimationPlayer")
		ap.seek(12.0, true)
		ap.play("Camera movement")
		
func _process(delta):
	
	if(done):
		get_tree().change_scene("Cutscene_Home.tscn")
func skip():
	get_tree().change_scene("Dungeon.tscn")

func _input(event):
	if event is InputEventKey:
		if(event.get_scancode() == KEY_ESCAPE):
			skip()
		else:
			start_game()
	if event is InputEventMouseButton:
		start_game()
