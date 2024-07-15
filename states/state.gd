extends Node
class_name State

const IDLE = "IDLE"
const WALKING = "WALKING"
const ATTACKING = "ATTACKING"
const DEFENDING = "DEFENDING"
const WAITING = "WAITING"

signal exit_state

func enter(_current_character: ArmyCharacterBody2D):
	pass

func exit(_current_character: ArmyCharacterBody2D):
	pass

func update(_current_character: ArmyCharacterBody2D, _delta):
	pass
