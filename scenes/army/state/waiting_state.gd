extends ArmyState

func enter(_current_character: ArmyCharacterBody2D):
	print("Entering Waiting State")

func exit(_current_character: ArmyCharacterBody2D):
	print("Exiting Waiting State")

func update(current_character: ArmyCharacterBody2D, _delta):
	print("Waiting")
	exit_state.emit()
	current_character.start_waiting()
	current_character.get_guid().set_all_disable(true)
