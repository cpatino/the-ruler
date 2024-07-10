extends Control

@export var character:ArmyCharacterBody2D

func _on_move_button_pressed():
	set_state(ArmyCharacterBody2D.STATE_MOVE)

func _on_attack_button_pressed():
	set_state(ArmyCharacterBody2D.STATE_ATTACK)

func _on_defend_button_pressed():
	set_state(ArmyCharacterBody2D.STATE_DEFEND)

func _on_end_turn_button_pressed():
	set_state(ArmyCharacterBody2D.STATE_END_TURN)

func set_state(new_state:String):
	hide()
	character.set_state(new_state)

func disable_button(state:String):
	if state == ArmyCharacterBody2D.STATE_MOVE:
		$Panel/VBoxContainer/MoveButton.set_disabled(true)
