class_name SoldierCamera2D
extends Camera2D

@export var character:CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if character:
		global_position = character.global_position
