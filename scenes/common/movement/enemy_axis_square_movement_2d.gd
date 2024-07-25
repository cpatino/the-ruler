extends Node2D
class_name EnemyAxisSquareMovement2D

@export var enemy: EnemyArea2D
@export var max_movements:int

const CONSTANT_SPEED = 250
const GRID_SIZE = Vector2(40, 40)
const EPSILON = 0.1

# From which grid is playing trying to start movement
var from_position: Vector2
# To which grid is playing trying to start movemenet
var to_position: Vector2
# The initial position of the character (remaining movements = max_movements)
var init_position: Vector2

var remaining_movements:int
var last_movement_value:int

func _physics_process(delta):
	if not enemy.waiting and remaining_movements > 0:
		move_character(delta)

func init_from_and_to_positions(target_position: Vector2):
	remaining_movements = max_movements
	print("target position", target_position)
	print("enemy position", enemy.position)
	var displacement_vector = target_position - enemy.position
	print("displacement vector", displacement_vector)
	if (0 - displacement_vector.x) < (0 - displacement_vector.y):
		to_position = target_position + Vector2(0, GRID_SIZE.y)
	else:
		to_position = target_position + Vector2(GRID_SIZE.x, 0)
	print("to position", to_position)
	from_position = enemy.position

func move_character(delta: float):
	var current_position = enemy.position
	var new_position = calculate_new_position(current_position, delta)
	move_and_slide(new_position)
	# if character is in the same possition (collision), then move it back to the last grid position
	if (enemy.position == current_position):
		move_and_slide(from_position)

func calculate_new_position(current_position: Vector2, delta: float):
	last_movement_value = remaining_movements
	var new_position = current_position.move_toward(to_position, CONSTANT_SPEED * delta)
	return to_position if new_position.distance_to(to_position) < EPSILON else new_position

func move_and_slide(new_position: Vector2):
	calculate_remaining_movements(new_position)
	enemy.position = new_position
	if (new_position == to_position or new_position == from_position):
		restart_from_and_to_positions()

func calculate_remaining_movements(new_position: Vector2):
	print("from position", from_position)
	print("new position", new_position)
	var distance = new_position - from_position
	var x = abs(distance.x)
	var y = abs(distance.y)
	print("x distance", fmod(x, 40))
	print("y distance", fmod(y, 40))
	if (x > 0 and fmod(x, 40) == 0) or (y > 0 and fmod(y, 40) == 0):
		remaining_movements -= 1
	print(remaining_movements)

func restart_from_and_to_positions():
	enemy.waiting = true
	to_position = Vector2(0, 0)
	from_position = Vector2(0, 0)
