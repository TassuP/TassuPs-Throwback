extends KinematicBody2D

var walk_spd = 150.0
var smooth_moves = 0.2
var move_vec = Vector2(0.0, 0.0)
var gfx

func _ready():
	gfx = get_node("Gfx")

func _process(delta):
	walking(delta)

func walking(delta):
	
	delta *= 60.0
	
	var moving = false
	if(Input.is_action_pressed("ui_left")):
		gfx.set_scale(Vector2(-1.0, 1.0))
		moving = true
		move_vec = move_vec.linear_interpolate(Vector2(-1.0, move_vec.y/2.0), smooth_moves * delta)
	if(Input.is_action_pressed("ui_right")):
		gfx.set_scale(Vector2(1.0, 1.0))
		moving = true
		move_vec = move_vec.linear_interpolate(Vector2(1.0, move_vec.y/2.0), smooth_moves * delta)
	if(Input.is_action_pressed("ui_up")):
		moving = true
		move_vec = move_vec.linear_interpolate(Vector2(move_vec.x/2.0, -1.0), smooth_moves * delta)
	if(Input.is_action_pressed("ui_down")):
		moving = true
		move_vec = move_vec.linear_interpolate(Vector2(move_vec.x/2.0, 1.0), smooth_moves * delta)
	if(moving == false):
		move_vec = move_vec.linear_interpolate(Vector2(0.0, 0.0), smooth_moves * delta)
	
	if(move_vec.length() >= 0.1):
		move_and_slide(move_vec * walk_spd)