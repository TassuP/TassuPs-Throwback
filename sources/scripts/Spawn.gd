extends Node2D

export(String, FILE) var scn1
export(String, FILE) var scn2
export(String, FILE) var scn3

var speed = 0.7

var interval = 10.0
var t = 0
var i = 0

func _ready():
	scn1 = load(scn1)
	scn2 = load(scn2)
	scn3 = load(scn3)
	

func _process(delta):
	delta *= speed
	t += delta
	
	if(t >= interval):
		t = 0
		
		var newscn
		if(i == 0):
			newscn = scn1.instance()
		if(i == 1):
			newscn = scn2.instance()
		if(i == 2):
			newscn = scn3.instance()
		
		add_child(newscn)
		newscn.set_global_scale(Vector2(0.0, 0.0))
		newscn.set_global_position(get_global_position())
		
		i += 1
		if(i > 2):
			i = 0
