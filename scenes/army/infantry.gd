extends CharacterBody2D

var is_active = false
var animated_sprite_player:AnimatedSpritePlayer2D

func _ready():
	var animated_sprite = load_animated_sprite()
	$AnimatedSpritePlayer2d.animated_sprite = animated_sprite
	$AnimatedSpritePlayer2d.animated_sprite_play_default()

func load_animated_sprite():
	if get_tree().has_group("army_textures"):
		var animated_sprites = []
		animated_sprites = get_tree().get_nodes_in_group("army_textures")
		return animated_sprites[0]
	else:
		var scene_path = "res://scenes/army/textures/base_2_animated_sprite_2d.tscn"
		
		var animated_sprite = load(scene_path)
		
		if animated_sprite:
			var animated_sprite_instance = animated_sprite.instantiate()
			add_child(animated_sprite_instance)
			return animated_sprite_instance
		else:
			print("Error: Animated Sprite Not Found")
			return null

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
