extends Control
class_name ArmyGuid

@export var character:ArmyCharacterBody2D

func _on_move_button_pressed():
	set_state(State.WALKING)

func _on_attack_button_pressed():
	set_state(State.ATTACKING)

func _on_defend_button_pressed():
	set_state(State.DEFENDING)

func _on_end_turn_button_pressed():
	set_state(State.WAITING)

func set_state(new_state:String):
	hide()
	character.set_state(new_state)

func set_visibility(new_value: bool):
	show() if new_value else hide()

func disable_movement_button():
	$Panel/VBoxContainer/MoveButton.set_disabled(true)

func set_all_disable(value: bool):
	$Panel/VBoxContainer/MoveButton.set_disabled(value)
	$Panel/VBoxContainer/AttackButton.set_disabled(value)
	$Panel/VBoxContainer/DefendButton.set_disabled(value)
	$Panel/VBoxContainer/WaitButton.set_disabled(value)
