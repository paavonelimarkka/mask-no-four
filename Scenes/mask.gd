extends TextureRect

var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var start_global_pos: Vector2

# Return animation settings
@export var return_duration: float = 0.25
@export var return_ease: Tween.EaseType = Tween.EASE_OUT
@export var return_trans: Tween.TransitionType = Tween.TRANS_QUAD

var _return_tween: Tween

func _ready() -> void:
	# Remember where the rect started (in global coordinates)
	await get_tree().process_frame  # ensures layout/anchors have applied
	start_global_pos = global_position

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Stop any running return tween if you start dragging again
			if _return_tween and _return_tween.is_running():
				_return_tween.kill()

			dragging = true
			drag_offset = get_global_mouse_position() - global_position
			accept_event()
		else:
			# Mouse released: stop dragging and return to the original spot
			dragging = false
			_return_to_start()
			accept_event()

	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() - drag_offset
		accept_event()

func _return_to_start() -> void:
	if return_duration <= 0.0:
		global_position = start_global_pos
		return

	_return_tween = get_tree().create_tween()
	_return_tween.set_ease(return_ease).set_trans(return_trans)
	_return_tween.tween_property(self, "global_position", start_global_pos, return_duration)
