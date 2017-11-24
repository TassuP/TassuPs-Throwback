extends Camera2D

export(NodePath) var target
export var attached = true
export var lock_y_div_x = false

func _ready():
	target = get_node(target)
	if(attached):
		if(lock_y_div_x):
			if(lock_y_div_x):
				var pos = target.get_global_position()
				pos.x = (pos.x - 512) / 3.0 + 512
				pos.y = 300.0
				set_global_position(pos)
		else:
			set_global_position(target.get_global_position())

func _process(delta):
	
	if(Game.paused):
		return
	
	if(attached):
#		var fake_reso = Vector2(1024.0, 600.0) / 3.0
		var pos = target.get_global_position()
		if(lock_y_div_x):
			pos.x = (pos.x - 512) / 3.0 + 512
			pos.y = 300.0
		pos = get_global_position().linear_interpolate(pos, delta * 3.0)
		if(Game.ugly_pixels):
			pos.x = stepify(pos.x, 3.0)
			pos.y = stepify(pos.y, 3.0)
		set_global_position(pos)
