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
var min_talk_delay = 1.5
var talking_speed = 0.5

var in_game = false
var intro_started = false
var ugly_pixels = true

var skippable_talk = true

#func _ready():
#	set_process(false)

func start_level():
	in_game = true
	skippable_talk = true
#	set_process(true)
	cursor = get_node("/root/Main/Node2D/Cursor")
	player = get_node("/root/Main/Node2D/Player")
	player_talk_label = get_node("/root/Main/Node2D/Talk label")
	
	AudioServer.set_bus_volume_db(0, 0.0)

func _process(delta):
	
	if(OS.is_window_maximized()):
		if(OS.is_window_fullscreen() == false):
			OS.set_window_fullscreen(true)
			
	
	if(intro_started):
		if(in_game == false):
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			return
		
		if(paused):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) == false):
		wait_for_release = false
	
	do_talking(delta)
	
func do_gameover():
	in_game = false
	get_tree().change_scene("GameOver.tscn")

func enter_pipe():
	in_game = false
	get_tree().change_scene("Overworld.tscn")
	
func wake_up():
	in_game = false
	get_tree().change_scene("Cutscene_Wakeup.tscn")

func player_says(say, caller):
	talk_caller = caller
	talking = true
	talk_i = 0
	talk_str = say
	talk_t = calc_text_speed(talk_str[talk_i])
	wait_for_release = true
#	print(talk_str[talk_i])

func do_talking(delta):
	
	if(paused):
		player_talk_label.set_visible(false)
		return
	
	if(talking):
		player_talk_label.set_visible(true)
		
		if(talk_str[talk_i] == "$"):
			print("Game starts aftertalk")
			talk_caller.after_talk()
			player_talk_label.set_visible(false)
			talking = false
			return
		else:
			player_talk_label.set_text(talk_str[talk_i])
		
		# Skipping lines
		if(skippable_talk):
			if(Input.is_mouse_button_pressed(BUTTON_LEFT) && wait_for_release == false):
				wait_for_release = true
				talk_t = 0.0
			
		# Advance talking
		talk_t -= delta
		if(talk_t <= 0.0):
			talk_i += 1
			
			# Stop talking when done
			if(talk_i >= talk_str.size()):
				talking = false
				player_talk_label.set_visible(false)
				skippable_talk = true
			else:
				# Say next line
#				print(talk_str[talk_i])
				talk_t = calc_text_speed(talk_str[talk_i])
		
		
func calc_text_speed(txt):
	var words = txt.split(" ")
	return max(talking_speed * words.size(), min_talk_delay)
	
	