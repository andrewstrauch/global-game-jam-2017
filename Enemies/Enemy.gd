extends Node2D

# Base class for Enemy
export var max_hp = 1
export var move_speed = 1

var hp

# Init
func _ready():
	hp = max_hp # Init the current HP to the max
	set_fixed_process(true) # Call every physics update
	pass

# Physics step
func _fixed_process(delta):
	# Process shit
	pass

# Generic function for taking damage
func takeDamage(damage):
	hp -= damage
	if(hp <= 0):
		destroy()
	pass

# Destroy function to remove enemy and do any other cleanup
func destroy():
	queue_free()
	pass