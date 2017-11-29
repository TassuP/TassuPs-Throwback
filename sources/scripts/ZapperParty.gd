extends Particles2D

var beam_length = 0.1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	
	if(Inventory.selected_item != "Zapper"):
		return
	
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) || is_emitting()):
		if(beam_length >= 0.0):
			if(is_emitting() == false):
				look_at(get_global_mouse_position())
			beam_length -= delta
			set_emitting(true)
		else:
			set_emitting(false)
	else:
		set_emitting(false)
		beam_length = 0.1