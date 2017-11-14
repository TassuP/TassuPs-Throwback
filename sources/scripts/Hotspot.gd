extends Area2D

export(PoolStringArray) var foot_str
export(PoolStringArray) var eye_str
export(PoolStringArray) var hand_str
export(String) var correct_item = ""

export var click_distance = 64.0
var foot_str_i = 0
var eye_str_i = 0
var hand_str_i = 0

var mouse_is_over = false
var wait_for_release = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if(Game.paused || Game.talking):
		return
	
	if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		if(wait_for_release == false):
			wait_for_release = true
			if(get_local_mouse_position().length() <= click_distance):
				
				# Foot
				if(Game.cursor.tool_mode == 0):
					if(foot_str != null):
						var s = foot_str[foot_str_i].split("#", false)
						Game.player_says(s, self)
						foot_str_i += 1
						if(foot_str_i >= foot_str.size()):
							foot_str_i = foot_str.size()-1
				
				# Eye
				if(Game.cursor.tool_mode == 1):
					if(eye_str != null):
						var s = eye_str[eye_str_i].split("#", false)
						Game.player_says(s, self)
						eye_str_i += 1
						if(eye_str_i >= eye_str.size()):
							eye_str_i = eye_str.size()-1
				
				# Hand
				if(Game.cursor.tool_mode == 2):
					if(hand_str != null):
						var s = hand_str[hand_str_i].split("#", false)
						Game.player_says(s, self)
						hand_str_i += 1
						if(hand_str_i >= hand_str.size()):
							hand_str_i = hand_str.size()-1
							
	else:
		wait_for_release = false

func trigger_stuff():
	print("Something happens now.")