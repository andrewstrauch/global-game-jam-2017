extends KinematicBody2D

const MOTION_SPEED = 180 # Pixels/second
var health = 3

func _ready():
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
	
func decrement_health():
	health -= 1
	if (health == 2):
		get_node("./HeartbeatPlayer").play_slow_heartbeat()
	elif (health == 1):
		get_node("./HeartbeatPlayer").play_fast_heartbeat()