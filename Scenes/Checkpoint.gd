extends Area2D

export var id = 0
var player_class = preload("res://Player/Player.gd")
var controller
#var sfx

func _ready():
	#sfx = get_node("Sfx")
	controller = get_node("/root/Controller")
	connect("body_enter", self, "on_checkpoint_body_enter")
	#get_node("Checkpoint").
	
	hide()

func on_checkpoint_body_enter(body):
	if (body extends player_class and controller.checkpoint != id):
		controller.checkpoint = id
		#get_node("AnimationPlayer").play("Effect")
		#sfx.play("checkpoint")