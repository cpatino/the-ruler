class_name ArmyCharacterBody2D
extends CharacterBody2D

signal end_turn

const STATE_IDLE = "IDLE"
const STATE_MOVE = "MOVE"
const STATE_ATTACK = "ATTACK"
const STATE_DEFEND = "DEFEND"
const STATE_END_TURN = "END_TURN"

var current_state = STATE_IDLE
var active = true
var defending = false
var turn_ended = false

func _ready():
	$AnimatedSpritePlayer2d.animated_sprite_play_default()

func _physics_process(delta):
	if active and not turn_ended:
		if Input.is_action_pressed("accept"):
			disable_current_state_action()
		elif current_state == STATE_MOVE:
			process_movement(delta)
		elif current_state == STATE_ATTACK:
			start_attack_action()
		elif current_state == STATE_DEFEND:
			set_defensive_posture()
		elif current_state == STATE_END_TURN:
			end_turn.emit()
			turn_ended = true
			set_active(false)

func set_active(new_value:bool):
	active = new_value
	if active:
		$ArmyGui.show()
	else:
		$ArmyGui.hide()

func is_turn_ended():
	return turn_ended

func disable_current_state_action():
	$ArmyGui.disable_button(current_state)
	cancel_state()

func cancel_state():
	$ArmyGui.show()
	set_state(STATE_IDLE)

func set_state(new_state:String):
	current_state = new_state

func process_movement(delta):
	if Input.is_action_pressed("cancel"):
		$AxisSquareMovement2D.cancel_movement()
		cancel_state()
		return
	
	$AxisSquareMovement2D.process_movement(delta)
	$AnimatedSpritePlayer2d.play()

func start_attack_action():
	print("attack")
	disable_current_state_action()

func set_defensive_posture():
	defending = true
	disable_current_state_action()
