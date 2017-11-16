extends Label

export(PoolStringArray) var txt

var i = 0
var t = 0.0

var offset
var cam
var sc

var delay = 0.0
var runtime = 0.0

func _ready():
	sc = get_scale()
	cam = get_parent()
	offset = get_position() / cam.get_zoom()
	set_as_toplevel(true)
	
	delay = Game.calc_text_speed(txt[i])
	


func _process(delta):
	set_scale(cam.get_zoom())
	set_global_position(cam.get_global_position() + offset * cam.get_zoom())
	
	# Advance
	runtime += delta
	t += delta
	if(t >= delay):
		t = 0
		i += 1
		if(i < txt.size()):
			delay = Game.calc_text_speed(txt[i])
			print(runtime, ": ", txt[i])
	
	# Stop when done
	if(i >= txt.size()):
		set_text("")
		queue_free()
		return
	
	# Show text
	set_text(txt[i])
	
	
	