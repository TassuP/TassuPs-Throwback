extends Label

var offset

func _ready():
	offset = get_global_position() - Game.player.get_global_position()

func _process(delta):
	set_global_position(Game.player.get_global_position() + offset)
