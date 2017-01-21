extends "res://Enemies/Enemy.gd"

var currentDirection = Vector2()

func _ready():
	get_node("ChangeDirectionTimer").connect("timeout", self, "_change_timer_timeout")
	_generate_direction()

func _fixed_process(delta):
	pass
	#move in direction

func _change_timer_timeout():
	_generate_direction()

func _generate_direction():
	var dir = randi()%4+1
#	if (dir == 1):
#		currentDirection = -1, 0
		
	get_node("ChangeDirectionTimer").set_one_shot(true)
	get_node("ChangeDirectionTimer").start()
	get_node("ChangeDirectionTimer").set_wait_time(5)