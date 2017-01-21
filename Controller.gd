extends Node

var root
# Lifeforce Management
var death = false

# Scene Management Variables
var map_layer
var current_map = null
var current_map_name = null
var checkpoint = 0
var player
# Camera Variables
var camera
var cam_collision
var cam_target = null
#var player_class = preload("res://Player/Player.gd")
#var is_shaking
#var shake_state = "none"
const CAM_OFFSET = -16
const CAM_HSTR = 3#4
const CAM_VSTR = 12#4
const CAM_CUTS = 12
# Input variables
var cutscene = false
#var press_full = false


func _ready():
	var _root=get_tree().get_root()
	root = _root.get_child(_root.get_child_count()-1)
	map_layer = root.get_node("Map")
	camera = root.get_node("Map/Camera")
	camera.make_current()
	set_fixed_process(true)
	#OS.set_window_fullscreen(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass

func _fixed_process(delta):
	if (cam_target != null):
		_scroll_camera()
	else:
		camera.set_pos(Vector2(160,90))
		
func get_player():
	var player_array = get_tree().get_nodes_in_group("player")
	return player_array[player_array.size()-1]
	
func kill_player():
	#Can refactor this if we give player a shield or something
	if (not death):
		death = true
		#get_player().death()
		root.get_node("DeathTimer").start()
		
		#Play death sound.
		#Stretch goal- play death sound based on type of death.
	
func end_cutscene():
	cutscene = false

func _scroll_camera():
	# Camera distance to player
#	print([cam_target, cam_target.get_name()])
	var pos = camera.get_global_pos()
	var opos = cam_target.get_global_pos()
	opos.y += CAM_OFFSET
	var dist = opos - pos
	dist = Vector2(round(dist.x),round(dist.y))
	var move = Vector2(dist.x/(CAM_HSTR + CAM_CUTS*(cam_target != player)), dist.y/CAM_VSTR)
#	print(dist)
	if (abs(move.x) < 1):
		move.x = sign(move.x)
	if (abs(move.y) < 1):
		move.y = sign(move.y)
		
#	# Horizontal scrolling
	if (dist.x != 0):
		pos.x += move.x
			
	# Vertical scrolling
	if (dist.y != 0):
		pos.y += move.y
#	
	pos.y = round(pos.y)
	pos.x = round(pos.x)
	# Resolve movement
	camera.set_pos(pos)

