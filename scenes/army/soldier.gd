extends CharacterBody2D

var active = true

func _ready():
	$AnimatedSpritePlayer2d.animated_sprite_play_default()

func _physics_process(delta):
	if active:
		if Input.is_action_pressed("cancel"):
			$AxisSquareMovement2D.cancel_movement()
			return
		
		$AxisSquareMovement2D.process_movement(delta)
		$AnimatedSpritePlayer2d.play()

func set_active(new_value:bool):
	active = new_value
