extends KinematicBody2D

var walk_spd = 150.0
var smooth_moves = 0.2
var move_vec = Vector2(0.0, 0.0)
var target_pos = Vector2(0.0, 0.0)
var gfx
var sz
var ani

var last_pos

var side
var front
var back

func _ready():
	Game.start_level()
	ani = get_node("AnimationPlayer")
	side = get_node("Side")
	front = get_node("Front")
	back = get_node("Back")
	
	ani.play("Standing")
	sz = get_global_scale()
	target_pos = get_global_position()
	last_pos = get_global_position()

func _process(delta):
	
	if(Game.paused || Game.talking):
		return
	
	walking(delta)
	
	facing()

func facing():
	
	var pos = get_global_position()
	
	# Is moving
	if(pos != last_pos):
		if(ani.get_current_animation() != "Walking"):
			ani.play("Walking")
		
		# Flip X scale
		if(pos.x > last_pos.x):
			front.set_scale(Vector2(1.0, 1.0))
			side.set_scale(Vector2(1.0, 1.0))
#			back.set_scale(Vector2(1.0, 1.0))
		else:
			front.set_scale(Vector2(-1.0, 1.0))
			side.set_scale(Vector2(-1.0, 1.0))
#			back.set_scale(Vector2(-1.0, 1.0))
		
		# Horizontal
		if(abs(pos.x - last_pos.x) > abs(pos.y - last_pos.y)):
			front.set_visible(false)
			back.set_visible(false)
			side.set_visible(true)
		
		# Vertical
		else:
			side.set_visible(false)
			
			# Down
			if(pos.y > last_pos.y):
				front.set_visible(true)
				back.set_visible(false)
			# Up
			else:
				front.set_visible(false)
				back.set_visible(true)
	else:
		if(ani.get_current_animation() != "Standing"):
			ani.play("Standing")
	
	last_pos = get_global_position()

func walking(delta):
	
	if(Game.event_running):
		move_vec = target_pos - get_global_position()
		if(move_vec.length() > 10.0):
			move_and_slide(move_vec.normalized() * walk_spd)
	else:
		if(Input.is_mouse_button_pressed(BUTTON_LEFT) && Game.cursor.tool_mode == 0 && Game.wait_for_release == false):
			target_pos = get_global_mouse_position() #get_local_mouse_position() + get_global_position()
		else:
			move_vec = target_pos - get_global_position()
			if(move_vec.length() > 10.0):
				move_and_slide(move_vec.normalized() * walk_spd)
