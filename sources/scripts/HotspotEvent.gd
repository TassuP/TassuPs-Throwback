extends Node2D

export var auto_start = false
enum HotspotEventType {walk_here, fade_in, fade_out, game_over, monolog}
export(int, "Walk Here", "Fade In", "Fade Out", "Game Over", "Monolog") var action
export(PoolStringArray) var monolog
export(NodePath) var next_event

var is_running = false
var t = 0.0
var fader = "/root/Main/Node2D/Camera2D/Control/Fader"

func _ready():
	
	fader = get_node(fader)
	
	if(next_event != null):
		next_event = get_node(next_event)
	
	set_process(false)
	if(auto_start):
		run()

func run():
	t = 0.0
	is_running = true
	set_process(true)
	
func stop():
	is_running = false
	set_process(false)
	Game.event_running = false
	if(next_event != null):
		next_event.run()
	
func after_talk():
	stop()
	
func _process(delta):
	if(Game.paused):
		return
		
	if(is_running):
		Game.event_running = true
		
		# Walk Here
		if(action == HotspotEventType.walk_here):
			var here = get_global_position()
			Game.player.target_pos = here
			if(Game.player.get_global_position().distance_to(here) <= 10.0):
				stop()
		
		# Fade In
		if(action == HotspotEventType.fade_in):
			t += delta / 2.0
			if(t > 1.0):
				t = 1.0
				stop()
			else:
				var c = fader.get_frame_color()
				c.a = clamp(1.0 - t, 0.0, 1.0)
				fader.set_frame_color(c)
				
		# Fade out
		if(action == HotspotEventType.fade_out):
			t += delta / 2.0
			if(t > 1.0):
				t = 1.0
				stop()
			else:
				var c = fader.get_frame_color()
				c.a = clamp(t, 0.0, 1.0)
				fader.set_frame_color(c)
				
		# Game Over
		if(action == HotspotEventType.game_over):
			Game.do_gameover()
			
		# Monolog
		if(action == HotspotEventType.monolog):
			is_running = false
			set_process(false)
			Game.event_running = false
			Game.player_says(monolog, self)