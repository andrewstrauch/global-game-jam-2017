extends Node2D

# Base class for Enemy
var hp = 0
var position = Vector2(1.0, 1.0)

# Init
func _ready():
	set_fixed_process(true) # Call every physics update
	pass

# Physics step
func _fixed_process(delta):
	# Process shit
	pass
