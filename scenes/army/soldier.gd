class_name ArmyCharacterBody2D
extends CharacterBody2D

signal end_turn

@onready var state_machine:ArmyStateMachine = $ArmyStateMachine
@onready var sprite_player:AnimatedSpritePlayer2D = $AnimatedSpritePlayer2d

var active: bool = true
var defending: bool = false
var waiting: bool = false

func _ready():
	state_machine.change_state(State.IDLE, self)
	sprite_player.animated_sprite_play_default()

func set_active(new_value: bool):
	active = new_value
	get_guid().set_visibility(active)

func is_active():
	return active

func start_waiting():
	waiting = true
	set_active(false)
	end_turn.emit()

func is_in_waiting():
	return waiting

func start_defending():
	defending = true
	start_waiting()

func is_in_defensive():
	return defending

func start_attacking():
	start_waiting()

func can_execute_action():
	return is_active() and not is_in_waiting()

func restart():
	defending = false
	waiting = false
	get_axis_movement().restart_remaining_movements()
	get_guid().set_all_disable(false)

func set_state(new_state:String):
	state_machine.change_state(new_state, self)

func get_axis_movement() -> AxisSquareMovement2D:
	return $AxisSquareMovement2D

func get_guid() -> ArmyGuid:
	return $ArmyGui

func get_sprite_player() -> AnimatedSpritePlayer2D:
	return sprite_player
