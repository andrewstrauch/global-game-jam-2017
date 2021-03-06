extends RigidBody2D

var isBulletFacingRight
var direction = int()
var speed = 14
var damage = 1
#var hurtful_type = preload("res://Enemies/HurtfulToPlayer.gd")
var enemy_class = preload("res://Enemies/Enemy.gd")
var tiles = preload("res://Scenes/Tiles1.res")
var pulseLight = preload("res://Scenes/PulseLight.tscn")
var shockWave = preload("res://Scenes/ShockWave.tscn")
var impactSamplePlayer = preload("res://Scenes/ImpactSamplePlayer.tscn")
#var cube = preload("res://Enemies/Cube.gd")

func _ready():
	get_node("Hitbox").connect("body_enter", self, "_on_hitbox_body_enter")
	set_fixed_process(true)
	
func init(incomingBool):
	isBulletFacingRight = incomingBool
	if(isBulletFacingRight == true):
		direction = 1
	else:
		direction = -1

func _fixed_process(delta):
	var pos = get_pos() + Vector2(speed * direction, 0)
	set_pos(pos)

func _on_hitbox_body_enter( body ):
	if(body extends enemy_class):
		body.takeDamage(damage)
		_death()
	if(body extends TileMap):
		# Create pulse & light source
		_spawn_shockwave()
		_death()
		
func _spawn_shockwave():
	var impactSoundPlayer = impactSamplePlayer.instance()
	get_parent().add_child(impactSoundPlayer)
	impactSoundPlayer.set_pos(get_pos())
	var soundNames = impactSoundPlayer.get_sample_library().get_sample_list()
	var randomIndex = randi() % soundNames.size()
	impactSoundPlayer.play(soundNames[randomIndex])
	
	var newWave = shockWave.instance()
	get_parent().add_child(newWave)
	newWave.set_pos(get_pos())
	
	var newLight = pulseLight.instance()
	get_parent().add_child(newLight)
	newLight.set_global_pos(get_global_pos())
		
func _death():
	queue_free()