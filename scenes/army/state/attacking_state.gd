extends ArmyState

func enter(_current_character: ArmyCharacterBody2D):
	print("Entering Attacking State")

func exit(_current_character: ArmyCharacterBody2D):
	print("Exiting Attacking State")

func update(current_character: ArmyCharacterBody2D, _delta):
	print("attack")
	exit_state.emit()
	current_character.start_attacking()
	current_character.get_guid().set_all_disable(true)
