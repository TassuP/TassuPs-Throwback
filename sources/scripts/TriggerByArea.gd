extends Area2D

export(NodePath) var anim
export(String) var anim_name

func _ready():
	if(anim != null):
		anim = get_node(anim)
		if(anim_name == null):
			print(get_name(), " is missing anim_name.")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_player_entered( body ):
	if(anim != null):
		if(body.get_name() == "Player"):
			print(get_name(), " triggered ", anim.get_name(), ": ", anim_name)
			anim.play(anim_name)
			queue_free()
