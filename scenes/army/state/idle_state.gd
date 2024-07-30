extends ArmyState

func enter(current_character: ArmyCharacterBody2D):
	current_character.get_sprite_player().animated_sprite_play_default()

func exit(_current_character: ArmyCharacterBody2D):
	print("Exiting Idle State")

func update(_current_character: ArmyCharacterBody2D, _delta):
	pass
