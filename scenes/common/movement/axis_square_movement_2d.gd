extends Node2D

@export var character:CharacterBody2D
@export var max_movements:int
const CONSTANT_SPEED = 250
const GRID_SIZE = Vector2(80, 80)
const EPSILON = 0.1

var from_position
var to_position

var remaining_movements:int
var last_movement_value:int

func _ready():
	remaining_movements = max_movements

func process_movement(delta:float):
	if not to_position == null and remaining_movements > 0:
		move_character(delta)
	else:
		init_vector_direction()

func move_character(delta:float):
	var current_position = character.position
	calculate_and_set_new_position(current_position, delta)
	if (character.position == current_position):
		set_position_to_character_and_restart(from_position)
		remaining_movements = last_movement_value
		print(remaining_movements)

func calculate_and_set_new_position(current_position:Vector2, delta:float):
	last_movement_value = remaining_movements
	var new_position = current_position.move_toward(to_position, CONSTANT_SPEED * delta)
	var adjusted_position = to_position if new_position.distance_to(to_position) < EPSILON else new_position
	if (adjusted_position == to_position):
		remaining_movements -= 1
	print(remaining_movements)
	set_position_to_character_and_restart(adjusted_position)

func init_vector_direction():
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	if input_direction.is_zero_approx():
		return
	init_from_and_to_positions(input_direction)

func init_from_and_to_positions(movement_vector:Vector2):
	to_position = character.position + movement_vector * GRID_SIZE
	from_position = character.position

func set_position_to_character_and_restart(new_position:Vector2):
	character.position = new_position
	character.move_and_slide()
	if (new_position == to_position or new_position == from_position):
		to_position = null
		from_position = null
