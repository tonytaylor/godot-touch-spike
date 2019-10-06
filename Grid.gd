extends Node2D

#
# GridManager
#
# Serves as a layer of indirection between input events and grid events
# (e.g. character tile moved, word lookup performed, word tile created, etc)
#
const GRID_ROWS = 2
const GRID_COLS = 2

var tile_sprite_template = "Area2D/Tile-%s/AnimatedSprite"
var last_node

var tiles = {
	"0,0": "V3",
	"0,1": "V6",
	"1,0": "V4",
	"1,1": "V5"
}

func load_root_node():
	var root_node = "/root/Node2D"
	var x = get_node(root_node)
	if x != null:
		x.connect("digit_swipe", self, "_on_digit_swipe")

func _on_digit_swipe(event, swipeData):
	print("/----------/\nswiped!\n%event: s\nswipe:%s" % [event.as_text(), swipeData])

func _ready():
	#load_root_node()
	pass

# --------------------------------------------------------------------------- #

func get_area_dims():
	var shape = $Area2D/CollisionShape2D.get_shape()
	var area = $Area2D.transform.get_origin()
	if shape != null:
		var xs = shape.extents
		return {
			'width': (xs.x * 2), 
			'height': (xs.y * 2),
			'origin': { 'x': area.x, 'y': area.y }
		}

func print_the_things(viewport, event, shape_idx):
	var textbox = $DebugTxt
	print_event_to_label(textbox, event)
	print_viewport_to_label(textbox, viewport)
	print_shape_index_to_label(textbox, shape_idx)

func print_event_to_label(label_node, event):
	label_node.text = event.as_text()
	label_node.text += "\n" + str(get_area_dims())

func print_viewport_to_label(label_node, viewport):
	label_node.text += "\n viewport: {x:%d, y:%d}" % [viewport.size.x, viewport.size.y]

func print_shape_index_to_label(label_node, shape_idx):
	label_node.text += "\n %d" % [shape_idx]

func print_coords(event):
	var input_x = event.position.x
	var input_y = event.position.y
	var grid_coords = _calc_grid_cell(event)
	var debug_string = "event coords:\t %d:%d\ngrid coords:\t %d:%d"
	print(debug_string % [input_x, input_y, grid_coords[0], grid_coords[1]])

func _on_Area2D_input_event(viewport, event, shape_idx):
	_highlight_sprite_on_input_event(event)

func _calc_grid_cell(event):
	var dims = get_area_dims()
	var position = event.position
	var row = position.x / (dims.width / GRID_ROWS)
	var col = position.y / (dims.height / GRID_COLS)
	return [round(floor(row)), round(floor(col))]
	
func _serialize_to_key(xs):
	return str(xs[0]) + "," + str(xs[1])

func _highlight_sprite_on_input_event(event):
	var grid_coords = _calc_grid_cell(event)
	var id = _serialize_to_key(grid_coords)
	var fullnode = tile_sprite_template % [tiles.get(id)]

	get_node(fullnode).play("go_red")

	if last_node and last_node != fullnode:
		get_node(last_node).play("default")
	last_node = fullnode