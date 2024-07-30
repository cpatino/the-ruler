extends ArmyState

func enter(current_character: ArmyCharacterBody2D):
	print("Entering Walking State")
	current_character.get_grid_movement().set_init_position()

func exit(current_character: ArmyCharacterBody2D):
	print("Exiting Walking State")
	if Input.is_action_pressed("accept"):
		current_character.get_grid_movement().set_init_position()
		current_character.get_guid().disable_movement_button()
	elif Input.is_action_pressed("cancel"):
		current_character.get_grid_movement().cancel_movement()

func update(current_character: ArmyCharacterBody2D, _delta):
	if Input.is_action_pressed("accept") or Input.is_action_pressed("cancel"):
		exit_state.emit()
		return
	
	current_character.get_grid_movement().move()
	current_character.get_sprite_player().play()