extends Container

export(NodePath) var post_prosessing
export(NodePath) var bg_node

func _ready():
	post_prosessing = get_node(post_prosessing)
	bg_node = get_node(bg_node)
	post_prosessing.get_material().set_shader_param("pixelize", Game.ugly_pixels)

func _input(event):
	if(event is InputEventKey):
		if(event.get_scancode() == KEY_ESCAPE && event.pressed):
			bg_node.set_visible(!is_visible())
			set_visible(!is_visible())
			Game.paused = is_visible()
			
			if(Game.paused):
				get_node("Fullscreen").pressed = OS.is_window_fullscreen()
				get_node("UglyPixels").pressed = Game.ugly_pixels


func toggle_fullscreen( pressed ):
	if(!pressed):
		OS.set_window_maximized(false)
	OS.set_window_fullscreen(pressed)


func toggle_ugly_pixels( pressed ):
	Game.ugly_pixels = pressed
	post_prosessing.get_material().set_shader_param("pixelize", Game.ugly_pixels)

func _on_Quit_pressed():
	get_tree().quit()

func _on_Resume_pressed():
	set_visible(false)
	bg_node.set_visible(false)
	Game.paused = false
