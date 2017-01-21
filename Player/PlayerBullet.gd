extends KinematicBody2D

var isBulletFacingRight
var direction = int()
var speed = 14
var damage = 1
#var hurtful_type = preload("res://Enemies/HurtfulToPlayer.gd")
var enemy_class = preload("res://Enemies/Enemy.gd")
var tiles = preload("res://Scenes/Tiles1.res")
var pulseLight = preload("res://Scenes/PulseLight.tscn")
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
		var newLight = pulseLight.instance()
		get_parent().add_child(newLight)
		newLight.set_pos(get_pos())
		
		_death()
func _death():
	queue_free()