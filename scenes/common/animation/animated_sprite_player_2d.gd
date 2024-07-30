class_name AnimatedSpritePlayer2D
extends Node2D

@export var animated_sprite: AnimatedSprite2D
const ANIMATION_FRONT = "front"
const ANIMATION_BACK = "back"
const ANIMATION_SIDE = "side"
const ANIMATION_IDLE = "idle"

func play():
	if Input.is_action_just_pressed("move_up"):
		animated_sprite_play(ANIMATION_BACK)
	elif Input.is_action_just_pressed("move_down"):
		animated_sprite_play(ANIMATION_FRONT)
	elif Input.is_action_just_pressed("move_left"):
		animated_sprite_play(ANIMATION_SIDE)
		flip_h(true)
	elif Input.is_action_just_pressed("move_right"):
		animated_sprite_play(ANIMATION_SIDE)
		flip_h(false)

func animated_sprite_play_default():
	animated_sprite_play(ANIMATION_IDLE)

func animated_sprite_play(animation):
	animated_sprite.play(animation)

func flip_h(value:bool):
	animated_sprite.flip_h = value
