extends Camera2D

export(NodePath) var target

func _ready():
	target = get_node(target)

func _process(delta):
	set_global_position(target.get_global_position())
