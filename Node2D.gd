extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

signal digit_swipe(evt)

func _handle_input(event):
	quit_game(event)
	_handle_touch(event)
		
func quit_game(event):
	if event is InputEventKey:
		if event.is_pressed() and event.scancode == KEY_ESCAPE:
			get_tree().quit()
			
func _handle_touch(event):
	$LastKeyVal.text = event.as_text()
	_handle_tap(event)
	_handle_swipe(event)
		
func _handle_swipe(event):
	if event is InputEventScreenDrag:
		emit_signal("digit_swipe", event, get_touch(event))

func _debug_print(event):
		$CurrentTile.text += ' %s \n' % [event.index]
		$CurrentTile.text += '%s \n' % [get_touch(event)]
		_handle_swipe_direction_coords(event)
		_handle_swipe_position_coords(event)
	
func get_touch(event):
	var touch_event = {}
	var rel = event.relative
	
	touch_event['x_dir'] = 'right' if rel.x > 0 else 'left' if rel.x < 0 else 'neutral'
	touch_event['y_dir'] = 'down' if rel.y > 0 else 'up' if rel.y < 0 else 'neutral'
	
	return touch_event

func _handle_swipe_direction_coords(event):
	$CurrentTile.text += " left: %s, top: %s" % [event.relative.x, event.relative.y]
	
func _handle_swipe_position_coords(event):
	$CurrentTile.text += " x: %s, y: %s" % [event.position.x, event.position.y]

func _handle_tap(event):
	if event is InputEventScreenTouch:
		pass

func _input(event):
	_handle_input(event)
