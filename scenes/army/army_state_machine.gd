extends Node
class_name ArmyStateMachine

var current_state: State = null
var states = {}

var current_character: ArmyCharacterBody2D = null

func _ready():
	preload_state(State.ATTACKING, "res://states/army/attacking_state.gd")
	preload_state(State.DEFENDING, "res://states/army/defending_state.gd")
	preload_state(State.IDLE, "res://states/army/idle_state.gd")
	preload_state(State.WAITING, "res://states/army/waiting_state.gd")
	preload_state(State.WALKING, "res://states/army/walking_state.gd")

func preload_state(state_name: String, resource_path: String):
	states[state_name] = load(resource_path).new()
	states[state_name].exit_state.connect(_on_exit_state)

func _physics_process(delta):
	if current_state and current_character.can_execute_action():
		current_state.update(current_character, delta)

func change_state(new_state_name: String, new_character: ArmyCharacterBody2D):
	if current_state:
		current_state.exit(current_character)
	current_state = states[new_state_name]
	if current_state:
		current_state.enter(new_character)
		current_character = new_character

func _on_exit_state():
	change_state(State.IDLE, current_character)
	current_character.get_guid().set_visibility(true)
