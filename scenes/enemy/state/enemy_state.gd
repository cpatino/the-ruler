extends Node
class_name EnemyState

const IDLE = "IDLE"
const WALKING = "WALKING"
const ATTACKING = "ATTACKING"

var enemy: EnemyArea2D = null
var target: ArmyCharacterBody2D = null

signal enemy_exit_state

func enter():
	pass

func exit():
	pass

func update():
	pass
