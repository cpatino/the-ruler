extends Area2D
class_name EnemyArea2D

var waiting = true

func get_grid_movement() -> GridMovement2D:
	return $GridMovement
