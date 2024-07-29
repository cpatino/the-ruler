extends Area2D
class_name EnemyArea2D

signal enemy_end_turn

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var state_machine: EnemyStateMachine = $StateMachine

var waiting = true

func can_execute_action():
	return not waiting

func restart():
	waiting = false
	get_grid_movement().restart_remaining_movements()

func get_grid_movement() -> GridMovement2D:
	return $GridMovement

func set_state(new_state: String, army: Array[ArmyCharacterBody2D]):
	var target_soldier: ArmyCharacterBody2D = calculate_target_soldier(army)
	state_machine.change_state(new_state, self, target_soldier)

func calculate_target_soldier(army: Array[ArmyCharacterBody2D]):
	var target_soldier: ArmyCharacterBody2D = null
	var min_distance: float = 1000000
	for soldier in army:
		set_target_position(soldier)
		var distance_to_target = navigation_agent.distance_to_target()
		if navigation_agent.distance_to_target() < min_distance:
			target_soldier = soldier
			min_distance = distance_to_target
	return target_soldier

func can_move():
	return get_grid_movement().can_move()

func set_target_position(target_soldier: ArmyCharacterBody2D):
	navigation_agent.set_target_position(target_soldier.global_position)
	navigation_agent.set_velocity(Vector2.ZERO)

func must_walk():
	return navigation_agent.distance_to_target() > GridMovement2D.GRID_SIZE.x

func get_next_path_position():
	return navigation_agent.get_next_path_position()
