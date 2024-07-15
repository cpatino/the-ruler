class_name SoldierCamera2D
extends Camera2D

@export var character:CharacterBody2D

func _process(_delta):
	if character:
		global_position = character.global_position
