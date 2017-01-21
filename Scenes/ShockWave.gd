extends Node2D

export var maxAge = 1  # Seconds
var age = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	
func _fixed_process(delta):
	age += delta
	if (age > maxAge):
		queue_free()
