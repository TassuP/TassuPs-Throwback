extends AnimationPlayer

export(String) var anim_name
export(NodePath) var condition1
export(NodePath) var condition2
export(NodePath) var condition3

var enabled = false
var done = false


func _ready():
	if(condition1 != null):
		condition1 = get_node(condition1)
		
	if(condition2 != null):
		condition2 = get_node(condition2)
		
	if(condition3 != null):
		condition3 = get_node(condition3)

func _process(delta):
	
	if(done):
		return
	
	enabled = true
	
	if(condition1 != null):
		if(condition1.has_triggered == false):
			enabled = false
			return
			
	if(condition2 != null):
		if(condition2.has_triggered == false):
			enabled = false
			return
			
	if(condition3 != null):
		if(condition3.has_triggered == false):
			enabled = false
			return
	
	if(enabled):
		print(get_name(), " play animation ", anim_name)
		play(anim_name)
		done = true
