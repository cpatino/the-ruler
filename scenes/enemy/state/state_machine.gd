extends Node
class_name EnemyStateMachine

const IDLE_STATE_SCRIPT = preload("res://scenes/enemy/state/idle_state.gd")
const WALKING_STATE_SCRIPT = preload("res://scenes/enemy/state/walking_state.gd")

var current_state: EnemyState = null
var states = {}

func _ready():
	preload_state(EnemyState.IDLE, IDLE_STATE_SCRIPT)
	preload_state(EnemyState.WALKING, WALKING_STATE_SCRIPT)

func preload_state(state_name: String, state_script):
	states[state_name] = state_script.new()
	states[state_name].enemy_exit_state.connect(_on_exit_state)

func _physics_process(_delta):
	if current_state and current_state.enemy.can_execute_action():
		current_state.update()

func change_state(new_state_name: String, next_enemy: EnemyArea2D, target_soldier: ArmyCharacterBody2D):
	if current_state:
		current_state.exit()
	current_state = states[new_state_name]
	if current_state:
		current_state.enemy = next_enemy
		current_state.target = target_soldier
		current_state.enter()

func _on_exit_state():
	change_state(EnemyState.IDLE, current_state.enemy, current_state.target)
