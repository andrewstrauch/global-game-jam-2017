extends Node2D

const map_names = {
	"title": "res://Scenes/TitleScreen.tscn",
	"map1": "res://Scenes/Map1/Map1.tscn"
}

#Controller variable
var controller

var load_state = 0
var load_timer
var tmap
var tcp

func _ready():
	get_node("LoadTimer").connect("timeout", self, "_on_LoadTimer_timeout")
	controller = get_node("/root/Controller")
	load_timer = get_node("LoadTimer")
	_change_map("map1", 0)
	# _change_map("title", 0)
	set_fixed_process(true)
	
func _on_DeathTimer_timeout():
	controller.death = false
	_change_map(controller.current_map_name, controller.checkpoint)
	
func _fixed_process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	if(Input.is_key_pressed(KEY_R)):
		_change_map("map1", 0)

func _change_map(map, cp):
	if (load_state == 0):
		#controller.begin_cutscene()
		if (controller.current_map != null):
			#controller.fader.play("FadeOut")
			#controller.ui.hide()
			pass
		load_timer.set_wait_time(0.5)
		load_timer.start()
		tmap = map
		tcp = cp
		load_state = 1
	elif (load_state == 1):
		controller.cam_target = null
		if (controller.current_map != null):
			controller.current_map.queue_free()
			controller.current_map.set_name(controller.current_map.get_name() + "_deleted" )
		var m = load(map_names[map])
		controller.checkpoint = cp
		controller.current_map = m.instance()
		controller.current_map_name = map
		controller.map_layer.add_child(controller.current_map)
		#controller.hide_bosshp()
		for cps in get_tree().get_nodes_in_group("Checkpoints"):
				if (cps.id == controller.checkpoint):
					controller.player = controller.get_player()
					controller.player.set_global_pos(cps.get_global_pos()-Vector2(0, -1))
		load_timer.set_wait_time(1)
		load_timer.start()
		load_state = 2
	else:
		#controller.end_cutscene()
#		if (map_names[controller.current_map_name] != "title"):
#			controller.ui.show()
		#controller.fader.play("FadeIn")
		load_state = 0

func _on_LoadTimer_timeout():
	_change_map(tmap, tcp)
