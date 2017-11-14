extends Node2D

var tool_mode = 1
# 0 = foot
# 1 = eye
# 2 = hand

var foot
var eye
var eye_cant
var hand
var hand_cant

var hotspots
var is_over_hotspot = false

var pos
var wait_for_release = false

func _ready():
	foot = get_node("Foot")
	eye = get_node("Eye")
	eye_cant = eye.get_node("Can't")
	hand = get_node("Hand")
	hand_cant = hand.get_node("Can't")
	
	hotspots = get_tree().get_nodes_in_group("Hotspots")

func _process(delta):
	
	if(Game.paused):
		foot.set_visible(false)
		eye.set_visible(false)
		hand.set_visible(false)
		return
	
	# Choose tool mode
	if(Input.is_mouse_button_pressed(BUTTON_RIGHT)):
		if(wait_for_release == false):
			wait_for_release = true
			tool_mode += 1
			if(tool_mode >= 3):
				tool_mode = 0
	else:
		wait_for_release = false
	
	pos = get_global_mouse_position()
	set_global_position(pos)
	
	check_hotspots()
	choose_cursor()


func choose_cursor():
	if(is_over_hotspot):
		hand_cant.set_visible(false)
		eye_cant.set_visible(false)
	else:
		hand_cant.set_visible(true)
		eye_cant.set_visible(true)
	
	# Foot
	if(tool_mode == 0):
		foot.set_visible(true)
		eye.set_visible(false)
		hand.set_visible(false)
	# Eye
	if(tool_mode == 1):
		foot.set_visible(false)
		eye.set_visible(true)
		hand.set_visible(false)
	# Hand
	if(tool_mode == 2):
		foot.set_visible(false)
		eye.set_visible(false)
		hand.set_visible(true)
	
func check_hotspots():
	is_over_hotspot = false
	var i = 0
	while(i < hotspots.size()):
		if(pos.distance_to(hotspots[i].get_global_position()) <= hotspots[i].click_distance):
			
			if(tool_mode == 0 && hotspots[i].foot_str != null):
				is_over_hotspot = true
			if(tool_mode == 1 && hotspots[i].eye_str != null):
				is_over_hotspot = true
			if(tool_mode == 2 && hotspots[i].hand_str != null):
				is_over_hotspot = true
		i += 1