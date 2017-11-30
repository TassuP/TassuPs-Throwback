extends Particles2D

export(NodePath) var sfx
var beam_length = 0.1

func _ready():
	sfx = get_node(sfx)

func _process(delta):
	
	if(Inventory.selected_item != "Zapper"):
		return
	
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) || is_emitting()):
		if(beam_length >= 0.0):
			if(is_emitting() == false):
				look_at(get_global_mouse_position())
				sfx.play()
			beam_length -= delta
			set_emitting(true)
		else:
			set_emitting(false)
	else:
		set_emitting(false)
		beam_length = 0.1