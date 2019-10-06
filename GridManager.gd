extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# still new to gdscript and not sure how to use typing
# area:
# 	dictionary containing:
#		- width: area width
# 		- height: area height
#		- origin: object
#			- x: origin x coordinate
# 			- y: origin y coordinate
var _area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func is_area(area):
	return true

func set_grid(area):
	""" Takes an Area2D object. Stored as: _area."""
	_area = area
	
func get_grid():
	return _area
