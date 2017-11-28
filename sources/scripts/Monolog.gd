extends Node

export(PoolStringArray) var monolog
export var autostart = false
export(NodePath) var next_event
export var skippable = true

func _ready():
	
	if(next_event != null):
		next_event = get_node(next_event)
	
	if(autostart):
		start_monolog()
		set_process(false)
	else:
		set_process(true)

func start_monolog():
	Game.skippable_talk = skippable
	Game.player_says(monolog, self)

func trigger_stuff():
	print("trigger_stuff in ", get_name())
	pass
	
func after_talk():
	print("trigger_stuff in ", get_name())
	if(next_event != null):
		next_event.run()
	
func _process(delta):
	if(autostart):
		start_monolog()
		set_process(false)