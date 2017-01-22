
extends TileMap

const TILE_INDEX = 10

# Member variables

# Boundaries for the fog rectangle
var x_min = -100 # Left start tile
var x_max = 100 # Right end tile
var y_min = -100 # Top start tile
var y_max = 100 # Bottom end tile

var position # Player's position

# Variables to check if the player moved
var x_old
var y_old

# Array to build up the visible area like a square.
# First value determines the width/height of the tip.
# Here it would be 2*2 + 1 = 5 tiles wide/high.
# Second value determines the total squares size.
# Here it would be 5*2 + 1 = 10 tiles wide/high.
var l = range(1, 2)


func set_visible(x,y, index=TILE_INDEX):
	x = int(x/get_cell_size().x)
	# Switching from positive to negative tile positions
	# causes problems because of rounding problems
	if x < 0:
		x -= 1 # Correct negative values
	
	y = int(y/get_cell_size().y)
	var end = l.size() - 1
	var start = 0
	for steps in range(l.size()):
		for m in range(x - l[end], x + l[end] + 1):
			for n in range(y - l[start], y + l[start] + 1):
				set_cell(m, n, index)
		end -= 1
		start += 1

func _ready():
	# Create a square filled with the 100% opaque fog
	for x in range(x_min, x_max):
		for y in range(y_min, y_max):
			set_cell(x, y, TILE_INDEX, 0, 0)
	#set_fixed_process(true)
