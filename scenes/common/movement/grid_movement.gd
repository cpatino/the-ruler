extends Node2D
class_name GridMovement2D

@export var area_to_move: Area2D
@export var max_movements: int = 0
@export var ai: bool = false

const GRID_SIZE: Vector2 = Vector2(40, 40)

var tween_started: bool = false
var remaining_movements: int = 0

var tween: Tween
var from_position: Vector2 = Vector2.INF
var init_position: Vector2 = Vector2.INF

var ai_direction: Vector2 = Vector2.INF

func _ready():
	restart_remaining_movements()
	area_to_move.connect("body_entered", _on_body_entered)
	area_to_move.connect("area_entered", _on_area_entered)

func _on_area_entered(_area: Area2D):
	print("on area entered")
	restart_position()

func _on_body_entered(_body: Node2D):
	print("on body entered")
	restart_position()

func restart_position():
	if tween:
		tween.stop()
	tween_property_position(from_position, 0)
	remaining_movements += 1

func move():
	print("remaining movements ", remaining_movements)
	if can_move():
		var direction = get_direction() * GRID_SIZE
		if Vector2.ZERO != direction:
			from_position = area_to_move.position
			tween_property_position(from_position + direction, 0.5)
			remaining_movements -= 1

func can_move():
	return not tween_started && remaining_movements > 0

func get_direction():
	return get_direction_for_ia() if ai else get_direction_from_input()

func get_direction_from_input():
	return Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))

func get_direction_for_ia():
	return ai_direction

func tween_property_position(new_position: Vector2, duration: float):
	tween_started = true
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(area_to_move, "position", new_position, duration)
	tween.connect("finished", _on_tween_finished)

func _on_tween_finished():
	tween_started = false

func restart_remaining_movements():
	remaining_movements = max_movements

func set_init_position():
	init_position = area_to_move.position
	from_position = area_to_move.position

func cancel_movement():
	if not init_position == Vector2.INF:
		tween.stop()
		tween_property_position(init_position, 0)
		from_position = init_position
		restart_remaining_movements()
