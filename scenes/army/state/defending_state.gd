extends ArmyState

func enter(_current_character: ArmyCharacterBody2D):
	print("Entering Defending State")

func exit(_current_character: ArmyCharacterBody2D):
	print("Exiting Defending State")

func update(current_character: ArmyCharacterBody2D, _delta):
	print("Defend")
	exit_state.emit()
	current_character.start_defending()
	current_character.get_guid().set_all_disable(true)
