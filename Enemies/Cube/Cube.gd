extends "res://Enemies/Enemy.gd"

var points = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _fixed_process(delta):
	# refresh the points in the path
	#var player_pos = get_tree().get_current_scene().get_node('Player').get_pos()
	# get_tree().get_root().get_node(controller.current_map)
	var player_pos = get_node('../../Player').get_global_pos()

	print('player pos: ' + str(player_pos))
	print('current pos: ' + str(get_global_pos()))
	points = get_node("../../Foreground/Navigation2D").get_simple_path(get_global_pos(), player_pos, false)
	print(points)

	# if the path has more than one point
	if points.size() > 1:
		var distance = points[1] - get_global_pos()
		var direction = distance.normalized() # direction of movement
		#if distance.length() > eps or points.size() > 2:
		move(direction*move_speed)
		#else:
		#	move(Vector2(0, 0)) # close enough - stop moving
		#update() # we update the node so it has to draw it self again

func _draw():
	print('drawing...')
	# if there are points to draw
	if points.size() > 1:
		for p in points:
			draw_circle(p - get_global_pos(), 8, Color(1, 0, 0)) # we draw a circle (convert to global position first)