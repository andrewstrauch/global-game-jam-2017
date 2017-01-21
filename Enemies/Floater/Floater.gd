extends "res://Enemies/Enemy.gd"

func _init():
	move_speed = 0.3

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _fixed_process(delta):
	# refresh the points in the path
	#var player_pos = get_tree().get_current_scene().get_node('Player').get_pos()
	# get_tree().get_root().get_node(controller.current_map)
	var player_pos = get_node('../../Player').get_global_pos()
	var distance = player_pos - get_global_pos()
	var direction = distance.normalized() # direction of movement
	#if distance.length() > eps or points.size() > 2:
	move(direction*move_speed)