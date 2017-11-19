extends Area2D

export(PoolStringArray) var foot_str
export(PoolStringArray) var eye_str
export(PoolStringArray) var hand_str
export(String) var correct_item = ""
export(PoolStringArray) var wrong_str
export(NodePath) var node_to_trigger
export var enabled = true
export var one_shot = true
export var delete_if_newt = false
export var enable_if_newt = false
var has_triggered = false

export var click_distance = 64.0

var foot_str_i = 0
var eye_str_i = 0
var hand_str_i = 0
var wrong_str_i = 0

var mouse_is_over = false
var wait_for_release = false

func _ready():
	if(node_to_trigger != null):
		node_to_trigger = get_node(node_to_trigger)
		
	if(wrong_str == null):
		wrong_str = []
		wrong_str.append("Umm.. No.")
		wrong_str.append("Nah..")
		wrong_str.append("Meh..")
		

func run():
	enabled = true
	set_visible(true)

func _process(delta):
	if(Game.paused || Game.talking):
		return
		
	if(delete_if_newt):
		if(Game.player.newt_mode):
			queue_free()
			return
	if(enable_if_newt):
		if(Game.player.newt_mode):
			enabled = true
		
	if(enabled == false):
		return
		
	if(has_triggered):
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
							if(one_shot):
								foot_str_i = foot_str.size()-1
							else:
								foot_str_i = 0
				# Eye
				if(Game.cursor.tool_mode == 1):
					if(eye_str != null):
						var s = eye_str[eye_str_i].split("#", false)
						Game.player_says(s, self)
						eye_str_i += 1
						if(eye_str_i >= eye_str.size()):
							if(one_shot):
								eye_str_i = eye_str.size()-1
							else:
								eye_str_i = 0
				# Hand
				if(Game.cursor.tool_mode == 2):
					if(hand_str != null):
						var s = hand_str[hand_str_i].split("#", false)
						Game.player_says(s, self)
						hand_str_i += 1
						if(hand_str_i >= hand_str.size()):
							if(one_shot):
								hand_str_i = hand_str.size()-1
							else:
								hand_str_i = 0
								
				# Item
				if(Game.cursor.tool_mode >= 3):
					print("Use ", Inventory.selected_item, " with ", get_name())
					if(Inventory.selected_item == correct_item):
						after_talk()
					else:
						var s = wrong_str[wrong_str_i].split("#", false)
						Game.player_says(s, self)
						wrong_str_i += 1
						if(wrong_str_i >= wrong_str.size()):
							wrong_str_i = 0
						
							
	else:
		wait_for_release = false

func after_talk():
	if(node_to_trigger != null):
		if(one_shot == false || has_triggered == false):
			print(get_name(), " triggered ",node_to_trigger.get_name())
			node_to_trigger.run()
			has_triggered = true
	else:
		print(get_name(), " doesn't have a node to trigger.")