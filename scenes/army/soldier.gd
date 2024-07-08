extends CharacterBody2D

var is_active = false

func _ready():
	$AnimatedSpritePlayer2d.animated_sprite_play_default()

func _physics_process(delta):
	if is_active:
		$AxisSquareMovement2D.process_movement(delta)
		$AnimatedSpritePlayer2d.play()

# Función para activar este CharacterBody2D
func activate():
	is_active = true

# Función para desactivar este CharacterBody2D
func deactivate():
	is_active = false
