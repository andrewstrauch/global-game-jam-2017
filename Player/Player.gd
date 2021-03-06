extends KinematicBody2D

const MOTION_SPEED = 180 # Pixels/second
const HEARTBEAT_SLOW_HP = 2
const HEARTBEAT_FAST_HP = 1
const MAX_HEALTH = 3
var health = MAX_HEALTH
var controller
var isPullingTrigger = false
var weaponCanFire = bool (true)
var isPlayerFacingRight = false
var maxAmmo = 6
var ammo #This is for tracking your current bullets
var reloadTimeInSeconds = 3 #How fast you reload
var isReloading = false

var pulseLight = preload("res://Scenes/PulseLight.tscn")
var shockWave = preload("res://Scenes/ShockWave.tscn")

func _ready():
	ammo = maxAmmo
	controller = get_node("/root/Controller")
	controller.cam_target = self
	get_node("WeaponFireIntervalTimer").set_one_shot(true)
	weaponCanFire = true
	get_node("WeaponFireIntervalTimer").connect("timeout", self, "_weapon_fire_interval_timer_timeout")
	get_node("WeaponReloadTimer").set_one_shot(true)
	get_node("WeaponReloadTimer").connect("timeout", self, "_weapon_reload_timer_timeout")
	
	set_fixed_process(true)

func _fixed_process(delta):
	var motion = Vector2()
	
	if (Input.is_key_pressed(KEY_W)):
		motion += Vector2(0, -1)
	if (Input.is_key_pressed(KEY_S)):
		motion += Vector2(0, 1)
	if (Input.is_key_pressed(KEY_A)):
		motion += Vector2(-1, 0)
	if (Input.is_key_pressed(KEY_D)):
		motion += Vector2(1, 0)
	
	motion = motion.normalized()*MOTION_SPEED*delta
	move(motion)
	
	isPullingTrigger = Input.is_mouse_button_pressed(1)
	
	print(get_node("WeaponReloadTimer").get_time_left())
	
	if (ammo <= 0 && not isReloading):
		isReloading = true
		get_node("WeaponReloadTimer").set_wait_time(reloadTimeInSeconds)
		get_node("WeaponReloadTimer").start()
	
	if (isPullingTrigger && weaponCanFire && ammo > 0):
			weaponCanFire = false
			_weapon_shoot()
	
func reset_health():
	health = MAX_HEALTH
	get_node("./HeartbeatPlayer").stop_heartbeat()
	
func decrement_health(damage):
	health -= damage
	if (health <= HEARTBEAT_FAST_HP):
		get_node("./HeartbeatPlayer").play_slow_heartbeat()
	elif (health <= HEARTBEAT_SLOW_HP):
		get_node("./HeartbeatPlayer").play_fast_heartbeat()

func _weapon_shoot():
	ammo -= 1
	get_node("WeaponFireIntervalTimer").set_wait_time(.3)
	get_node("WeaponFireIntervalTimer").start()
	var shoot_speed = 1500
	var bullet = load("res://Player/PlayerBullet.tscn")
	
	var bi = bullet.instance()
	var bullet_rotation = get_angle_to(get_global_mouse_pos()) + self.get_rot()
	bi.set_rot(bullet_rotation)
	bi.set_pos(get_pos() + Vector2(0, 0))
	get_parent().add_child(bi)
	bi.apply_impulse(Vector2(), ( get_global_mouse_pos() - self.get_global_pos() ).normalized() * shoot_speed)

func _weapon_fire_interval_timer_timeout():
    weaponCanFire = true

func _weapon_reload_timer_timeout():
	ammo = maxAmmo
	isReloading = false

func _on_Hitbox_body_enter( body ):
	if(body extends TileMap):
		var playerRect = self.get_item_rect()
		var offset = Vector2(0, 0)
		# Create pulse & light source
		if (Input.is_action_pressed("ui_up")):
			offset += Vector2(0, -1) * (playerRect.size.height/2)
		if (Input.is_action_pressed("ui_down")):
			offset += Vector2(0, 1) * (playerRect.size.height/2)
		if (Input.is_action_pressed("ui_left")):
			offset += Vector2(-1, 0) * (playerRect.size.width/2)
		if (Input.is_action_pressed("ui_right")):
			offset += Vector2(1, 0) * (playerRect.size.width/2)
		_spawn_shockwave(offset)
		
func _spawn_shockwave( offset ):
	var newWave = shockWave.instance()
	get_parent().add_child(newWave)
	newWave.set_pos(get_pos() + offset)
	newWave.set_scale(Vector2(0.2, 0.2))
	var newLight = pulseLight.instance()
	get_parent().add_child(newLight)
	newLight.set_pos(get_pos() + offset)
	newLight.set_scale(Vector2(0.2, 0.2))
