extends Node2D

@export var character:CharacterBody2D
@export var max_movements:int
const CONSTANT_SPEED = 250
const GRID_SIZE = Vector2(40, 40)
const EPSILON = 0.1

# From which grid is playing trying to start movement
var from_position:Vector2
# To which grid is playing trying to start movemenet
var to_position:Vector2
# The initial position of the character (remaining movements = max_movements)
var init_position:Vector2

var remaining_movements:int
var last_movement_value:int

func _ready():
	init_position = character.position
	cancel_movement()

func process_movement(delta:float):
	if to_position.length() > 0 and remaining_movements > 0:
		move_character(delta)
	else:
		init_vector_direction()

func move_character(delta:float):
	var current_position = character.position
	var new_position = calculate_new_position(current_position, delta)
	move_and_slide(new_position)
	# if character is in the same possition (collision), then move it back to the last grid position
	if (character.position == current_position):
		move_and_slide(from_position)

func calculate_new_position(current_position:Vector2, delta:float):
	last_movement_value = remaining_movements
	var new_position = current_position.move_toward(to_position, CONSTANT_SPEED * delta)
	return to_position if new_position.distance_to(to_position) < EPSILON else new_position

func move_and_slide(new_position:Vector2):
	calculate_remaining_movements(new_position)
	character.position = new_position
	character.move_and_slide()
	if (new_position == to_position or new_position == from_position):
		restart_from_and_to_positions()

func calculate_remaining_movements(new_position:Vector2):
	if (new_position == to_position):
		remaining_movements -= 1
	elif (new_position == from_position):
		remaining_movements = last_movement_value
	print(remaining_movements)

func init_vector_direction():
	var input_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	if not input_direction.is_zero_approx():
		init_from_and_to_positions(input_direction.normalized())

func init_from_and_to_positions(movement_vector:Vector2):
	to_position = character.position + movement_vector * GRID_SIZE
	from_position = character.position

func cancel_movement():
	restart_from_and_to_positions()
	remaining_movements = max_movements
	character.position = init_position
	character.move_and_slide()

func restart_from_and_to_positions():
	to_position = Vector2(0, 0)
	from_position = Vector2(0, 0)
