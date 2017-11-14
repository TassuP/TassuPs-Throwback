extends KinematicBody2D

var walk_spd = 150.0
var smooth_moves = 0.2
var move_vec = Vector2(0.0, 0.0)
var target_pos = Vector2(0.0, 0.0)
var gfx

var zeldalike = false

func _ready():
	Game.start_level()
	gfx = get_node("Gfx")
	target_pos = get_global_position()
	

func _process(delta):
	
	if(Game.paused || Game.talking):
		return
	
	walking(delta)

func walking(delta):
	
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) && Game.cursor.tool_mode == 0 && Game.wait_for_release == false):
		target_pos = get_local_mouse_position() + get_global_position()
	else:
		move_vec = target_pos - get_global_position()
		if(move_vec.length() > 10.0):
			move_and_slide(move_vec.normalized() * walk_spd)