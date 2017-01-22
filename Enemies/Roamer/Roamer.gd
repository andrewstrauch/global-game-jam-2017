extends "res://Enemies/Enemy.gd"

var currentDirection = Vector2()

func _ready():
	get_node("ChangeDirectionTimer").connect("timeout", self, "_change_timer_timeout")
	_generate_direction()

func _fixed_process(delta):
	var motion = Vector2()
	
	if (currentDirection == Vector2(-1, 0)): #left
		motion += currentDirection
	if (currentDirection == Vector2(0, -1)): #up
		motion += currentDirection
	if (currentDirection == Vector2(1, 0)): #right
		motion += currentDirection
	if (currentDirection == Vector2(1, 0)): #down
		motion += currentDirection
	
	motion = motion.normalized()*MOTION_SPEED*delta
	move(motion)

func _change_timer_timeout():
	_generate_direction()

func _generate_direction():
	var dir = randi()%4+1
	if (dir == 1): #left
		currentDirection = Vector2(-1, 0)
	if (dir == 2): #up
		currentDirection = Vector2(0, -1)
	if (dir == 3): #right
		currentDirection = Vector2(1, 0)
	if (dir == 4): #down
		currentDirection = Vector2(1, 0)
		
	get_node("ChangeDirectionTimer").set_one_shot(true)
	get_node("ChangeDirectionTimer").start()
	get_node("ChangeDirectionTimer").set_wait_time(3)