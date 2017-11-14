extends Panel

export(NodePath) var post_prosessing

func _ready():
	post_prosessing = get_node(post_prosessing)

func _input(event):
	
	if(event is InputEventKey):
		if(event.get_scancode() == KEY_ESCAPE && event.pressed):
			set_visible(!is_visible())
			Game.paused = is_visible()



func _on_UglyPixels_toggled( pressed ):
	post_prosessing.get_material().set_shader_param("pixelize", pressed)
