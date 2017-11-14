extends Node

var player
var player_talk_label
var cursor

var paused = false
var talking = false
var event_running = false
var talk_i = 0
var talk_t = 0
var talk_str = null
var wait_for_release = false

var talk_caller
var min_talk_delay = 20
var talking_speed = 15

func _ready():
	set_process(false)

func start_level():
	set_process(true)
	cursor = get_node("/root/Main/Node2D/Cursor")
	player = get_node("/root/Main/Node2D/Player")
	player_talk_label = get_node("/root/Main/Node2D/Talk label")

func _process(delta):
	
	if(paused):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) == false):
		wait_for_release = false
	
	do_talking(delta)


func do_gameover():
	get_tree().change_scene("GameOver.tscn")

func player_says(say, caller):
	talk_caller = caller
	talking = true
	talk_i = 0
	talk_str = say
	talk_t = talk_str[talk_i].length() + min_talk_delay
	wait_for_release = true
#	print(talk_str[talk_i])

func do_talking(delta):
	if(talking):
		player_talk_label.set_visible(true)
		
		if(talk_str[talk_i] == "$"):
			talk_caller.after_talk()
			player_talk_label.set_visible(false)
			talking = false
			return
		else:
			player_talk_label.set_text(talk_str[talk_i])
		
		# Skipping lines
		if(Input.is_mouse_button_pressed(BUTTON_LEFT) && wait_for_release == false):
			wait_for_release = true
			talk_t = 0.0
			
		# Advance talking
		talk_t -= delta * talking_speed
		if(talk_t <= 0.0):
			talk_i += 1
			
			# Stop talking when done
			if(talk_i >= talk_str.size()):
				talking = false
				player_talk_label.set_visible(false)
			else:
				# Say next line
#				print(talk_str[talk_i])
				talk_t = talk_str[talk_i].length() + min_talk_delay
		