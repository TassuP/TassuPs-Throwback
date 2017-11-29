extends Node2D

var speed = 0.7
var t = 0.0
var tt = 0.0
var ttt = 0.0
var start_y
var end_y = 400.0
var dir = 1.0
var zapper_cooloff = 0.0
var die = false

func _ready():
	start_y = get_global_position().y
	start_y = 600.0 - start_y
	zapper_cooloff = randf()

func _process(delta):
	
	if(die):
		translate(Vector2(0.0, 1.0))
		rotate(delta * 2)
		return
		
	if(t >= 40.0 && !die):
		zapper_cooloff -= delta
		getting_hit()
	
	
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
		
func getting_hit():
	if(Inventory.selected_item != "Zapper"):
		return
		
	if(zapper_cooloff > 0.0):
		return
		
	if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		
		zapper_cooloff = randf()
		
		# Direction from player to alien
		var pos = get_global_position()
		var plrpos = Game.player.get_global_position()
		var plr2alien = pos - plrpos
		plr2alien = plr2alien.normalized()
		
		# Direction from player to cursor
		pos = get_global_mouse_position()
		var plr2cursor = pos - plrpos
		plr2cursor = plr2cursor.normalized()
		
		# Check if the directions match
		if(plr2cursor.dot(plr2alien) > 0.999 && randf() > 0.5):
			get_node("Fire").set_emitting(true)
			die = true