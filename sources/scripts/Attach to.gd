extends Node2D

export(NodePath) var to
var offset

func _ready():
	to = get_node(to)
	offset = get_global_position() - to.get_global_position()

func _process(delta):
	set_global_position(to.get_global_position() + offset)
