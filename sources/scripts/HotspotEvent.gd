extends Node2D

export var auto_start = false
enum HotspotEventType {walk_here, fade_in, fade_out, game_over, monolog, dream_on, dream_off, take, remove_item, enter_pipe, wake_up}
export(int, "Walk Here", "Fade In", "Fade Out", "Game Over", "Monolog", "Dream On", "Dream Off", "Take", "Remove Item", "Enter Pipe", "Wake Up") var action
export(PoolStringArray) var monolog
export(NodePath) var next_event
export(NodePath) var sound_fx
export(NodePath) var sound_fx_after

var is_running = false
var t = 0.0
export var speed = 1.0
var fader = "/root/Main/Node2D/Camera2D/Control/Fader"
var post_prosessing = "/root/Main/Node2D/Camera2D/Control/PostProsessing"

var has_triggered = false

func _ready():
	
	fader = get_node(fader)
	post_prosessing = get_node(post_prosessing)
	
	if(next_event != null):
		next_event = get_node(next_event)
		
	if(sound_fx != null):
		sound_fx = get_node(sound_fx)
		
	if(sound_fx_after != null):
		sound_fx_after = get_node(sound_fx_after)
	
	set_process(false)
	if(auto_start):
		run()

func run():
	t = 0.0
	is_running = true
	set_process(true)
	
	if(sound_fx != null):
		sound_fx._set_playing(true)
	
func stop():
	has_triggered = true
	is_running = false
	set_process(false)
	Game.event_running = false
	if(next_event != null):
		next_event.run()
		
	if(sound_fx_after != null):
		sound_fx_after._set_playing(true)
	
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
				
				AudioServer.set_bus_volume_db(0, - t * 40.0)
				
		# Game Over
		if(action == HotspotEventType.game_over):
			Game.do_gameover()
			
		# Monolog
		if(action == HotspotEventType.monolog):
			is_running = false
			set_process(false)
			Game.event_running = false
			Game.player_says(monolog, self)
			
		# Dream On
		if(action == HotspotEventType.dream_on):
			t += (delta / 2.0) * speed
			if(t > 1.0):
				t = 1.0
				stop()
			else:
				post_prosessing.get_material().set_shader_param("dream", t)
				
		# Dream Off
		if(action == HotspotEventType.dream_off):
			t += (delta / 2.0) * speed
			if(t > 1.0):
				t = 1.0
				stop()
			else:
				post_prosessing.get_material().set_shader_param("dream", 1.0 - t)
				
		# Take
		if(action == HotspotEventType.take):
			var here = get_global_position()
			Game.player.target_pos = here
			if(Game.player.get_global_position().distance_to(here) <= 10.0):
				stop()
				Inventory.add_item(get_parent().get_name())
				get_parent().queue_free()
				
		# Remove Item
		if(action == HotspotEventType.remove_item):
			stop()
			Inventory.remove_item(get_parent().get_name())
			get_parent().queue_free()
			
		# Enter Pipe
		if(action == HotspotEventType.enter_pipe):
			Game.enter_pipe()
			
		# Wake up
		if(action == HotspotEventType.wake_up):
			Game.wake_up()
