extends KinematicBody2D

const MOTION_SPEED = 180 # Pixels/second
var health = 3
var controller
var isPullingTrigger = false
var weaponCanFire = bool (true)
var isPlayerFacingRight = false


func _ready():
	controller = get_node("/root/Controller")
	controller.cam_target = self
	get_node("WeaponReloadTimer").set_one_shot(true)
	weaponCanFire = true
	get_node("WeaponReloadTimer").connect("timeout", self, "_weapon_reload_timer_timeout")
	#get_node("hitbox").connect("body_enter", self, "_on_hitbox_body_enter")
	
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
	
	isPullingTrigger = Input.is_key_pressed(KEY_SPACE)
	
	if (isPullingTrigger && weaponCanFire):
			weaponCanFire = false
			_weapon_shoot(motion)
	
func reset_health():
	health = 3
	get_node("./HeartbeatPlayer").stop_heartbeat()
	
func decrement_health():
	health -= 1
	if (health == 2):
		get_node("./HeartbeatPlayer").play_slow_heartbeat()
	elif (health == 1):
		get_node("./HeartbeatPlayer").play_fast_heartbeat()

func _weapon_shoot(motion):
	get_node("WeaponReloadTimer").set_wait_time(.3)
	get_node("WeaponReloadTimer").start()
	var bullet = load("res://Player/PlayerBullet.tscn")
	var bi = bullet.instance()
	get_tree().get_root().add_child(bi)
	bi.set_pos(get_pos() + Vector2(20, 20))
	#bi.init(motion)
	bi.init(isPlayerFacingRight)

func _weapon_reload_timer_timeout():
    weaponCanFire = true
