extends KinematicBody2D

#var motion = Vector2(0, 0)
#var click_radius = 64

onready var ctile = get_node("/root/Node2D/CurrentTile")

func _ready():
	var x = get_node("/root/Node2D")
	x.connect("digit_swipe", self, "_on_digit_tap")

func _on_digit_tap(event, data):
	ctile.text = event.as_text()
	ctile.text += "\n %s" % [str(data)]

func _on_TileV2_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		position = event.position
	get_node("/root/Node2D/Label2").text = "hit!"
	print("%s -> %d" % [viewport.get_property_list(), shape_idx])
