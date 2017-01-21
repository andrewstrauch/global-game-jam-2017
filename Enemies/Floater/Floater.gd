extends "res://Enemies/Enemy.gd"

export var aggroRange = 256.0

func _init():
	move_speed = 0.3

func _ready():
	pass

func _fixed_process(delta):
	var player_pos = get_node('../../Player').get_global_pos()
	var distance = player_pos - get_global_pos()
	var direction = distance.normalized() # direction of movement
	if (distance.length() < aggroRange):
		move(direction*move_speed)