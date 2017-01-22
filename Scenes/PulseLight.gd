extends Node2D

export var maxAge = 20  # Seconds
var age = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	
func _fixed_process(delta):
	Controller.current_map.get_node("Fog").set_visible(get_global_pos().x,
	 get_global_pos().y, -1)
	age += delta
	if (age > maxAge):
		Controller.current_map.get_node("Fog").set_visible(
			get_global_pos().x, get_global_pos().y)
		queue_free()