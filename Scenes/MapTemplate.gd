extends Node

var controller

func _ready():
	controller = get_node("/root/Controller")
	set_fixed_process(true)
	
func _fixed_process(delta):
	pass