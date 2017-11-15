extends Label

export(PoolStringArray) var txt
export var next_scene = true

var i = 0
var t = 0.0
var min_talk_delay = 1

var offset
var cam
var sc



func _ready():
	sc = get_scale()
	cam = get_parent()
	offset = get_position() / cam.get_zoom()
	set_as_toplevel(true)
	


func _process(delta):
	set_scale(cam.get_zoom())
	set_global_position(cam.get_global_position() + offset * cam.get_zoom())
	
	# Advance
	t += delta
	if(t >= 0.15 * txt[i].length() + min_talk_delay):
		t = 0
		i += 1
	
	# Stop when done
	if(i >= txt.size()):
		set_text("")
		queue_free()
		
		if(next_scene):
			Game.next_scene()
		return
	
	# Show text
	set_text(txt[i])