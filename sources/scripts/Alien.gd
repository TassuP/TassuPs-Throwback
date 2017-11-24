extends Node2D

var speed = 0.7
var t = 0.0
var tt = 0.0
var ttt = 0.0
var start_y
var end_y = 400.0
var dir = 1.0

func _ready():
	start_y = get_global_position().y
	start_y = 600.0 - start_y

func _process(delta):
	delta *= speed
	t += delta
	tt += delta
	ttt += delta
	
	var pos = get_global_position()
	pos.y = 600.0 - pos.y
	var s = 0.01 + (pos.y - start_y) / (end_y - start_y)
#	s = max(s, 0.02)
	set_global_scale(Vector2(1.0, 1.0) * s)
	
	if(tt >= 5.0):
		tt = 0.0
		ttt = 0.0
		dir *= -1
		
		pos = get_global_position()
		pos.x = (pos.x - 512.0) * (1.2 + s/2.0) + 512.0
		pos.y += 80 * s
		
		set_global_position(pos)
		
	if(ttt >= 1.0):
		ttt = 0.0
		translate(Vector2(64.0, 0.0) * s * dir)
		
