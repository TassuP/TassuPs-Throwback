extends Node2D

var tool_mode = 1
# 0 = foot
# 1 = eye
# 2 = hand
# 3+ = item

var foot
var eye
var eye_cant
var hand
var hand_cant

var items = []

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
	
	items = get_node("Items").get_children()
	
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
				var found = false
				while(found == false):
					if(tool_mode >= 3 + items.size()):
						tool_mode = 0
						found = true
					elif(Inventory.has_item(items[tool_mode - 3].get_name())):
						found = true
					else:
						tool_mode += 1
			if(tool_mode >= 3 + items.size()):
				tool_mode = 0
			
#			print(tool_mode)
	else:
		wait_for_release = false
	
	pos = get_global_mouse_position()
	set_global_position(pos)
	
	check_hotspots()
	choose_cursor()

#func _input(event):
#	if(event is InputEventMouseButton):
#		if(event.is_pressed()):
#			if(event.get_button_index() == BUTTON_WHEEL_UP):
#				tool_mode += 1
#
#				while(tool_mode < 3+items.size() && !Inventory.has_item(items[tool_mode - 3].get_name())):
#					tool_mode += 1
#
#				if(tool_mode >= 3+items.size()):
#					tool_mode = 0
#			if(event.get_button_index() == BUTTON_WHEEL_DOWN):
#				tool_mode -= 1



func choose_cursor():
	
	# Change tool_mode if selected item
	# has been removed from inventory
	if(tool_mode >= 3):
		if(Inventory.has_item(items[tool_mode - 3].get_name()) == false):
			print("selected item has been removed")
			tool_mode = 0
	
	# Hide all items
	var i = 0
	while(i < items.size()):
		items[i].set_visible(false)
		i += 1
	
	# Choose an item
	if(tool_mode >= 3):
		foot.set_visible(false)
		eye.set_visible(false)
		hand.set_visible(false)
		
		items[tool_mode - 3].set_visible(true)
		Inventory.select_item(items[tool_mode - 3].get_name())
		
		
	# Choose an action
	else:
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
	hotspots = get_tree().get_nodes_in_group("Hotspots")
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