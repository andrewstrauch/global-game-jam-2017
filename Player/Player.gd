extends KinematicBody2D

const MOTION_SPEED = 180 # Pixels/second
const HEARTBEAT_SLOW_HP = 2
const HEARTBEAT_FAST_HP = 1
var health = 3
var controller

func _ready():
	controller = get_node("/root/Controller")
	controller.cam_target = self
	set_fixed_process(true)

func _fixed_process(delta):
	var motion = Vector2()
	
	if (Input.is_action_pressed("ui_up")):
		motion += Vector2(0, -1)
	if (Input.is_action_pressed("ui_down")):
		motion += Vector2(0, 1)
	if (Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
	
	motion = motion.normalized()*MOTION_SPEED*delta
	move(motion)
	
func reset_health():
	health = 3
	get_node("./HeartbeatPlayer").stop_heartbeat()
	
func decrement_health(damage):
	health -= damage
	if (health <= HEARTBEAT_FAST_HP):
		get_node("./HeartbeatPlayer").play_slow_heartbeat()
	elif (health <= HEARTBEAT_SLOW_HP):
		get_node("./HeartbeatPlayer").play_fast_heartbeat()