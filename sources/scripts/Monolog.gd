extends Node

export(PoolStringArray) var monolog
export var autostart = false

func _ready():
	if(autostart):
		start_monolog()
		
func start_monolog():
	Game.player_says(monolog, self)

func trigger_stuff():
	print("trigger_stuff in ", get_name())
	pass