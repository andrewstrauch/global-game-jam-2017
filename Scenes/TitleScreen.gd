extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_StartButton_pressed():
	get_node("/root/root")._change_map("res://Scenes/Map1/Map1.tscn", 0)

func _on_ExitButton_pressed():
	get_tree().quit()