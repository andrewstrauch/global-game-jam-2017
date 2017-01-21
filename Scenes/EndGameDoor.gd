extends Node2D

var playerClass = load("res://Player.gd")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Hitbox_body_enter( body ):
	if (body == Controller.get_player()):
		get_node("/root/root")._change_map("title", 0)
