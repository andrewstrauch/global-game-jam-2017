extends StreamPlayer

var slow_heartbeat
var fast_heartbeat

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	slow_heartbeat = load("res://Sounds/heartbeat_slow.ogg")
	fast_heartbeat = load("res://Sounds/heartbeat_fast.ogg")
		
func stop_heartbeat():
	self.stop()
	
func play_slow_heartbeat():
	self.set_stream(slow_heartbeat)
	self.play()
	
func play_fast_heartbeat():
	self.set_stream(fast_heartbeat)
	self.play()