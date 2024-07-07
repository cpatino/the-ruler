# Script en el nodo principal
extends Node2D

@export var character_scene: PackedScene

var characters = []
var animated_sprites = []
var active_character = null

func _ready():
	animated_sprites.append(load("res://scenes/army/textures/base_animated_sprite_2d.tscn"))
	animated_sprites.append(load("res://scenes/army/textures/base_2_animated_sprite_2d.tscn"))
	
	for i in range(2):
		var character_instance = character_scene.instantiate()
		character_instance.position = Vector2(80 * i, 40)
		character_instance.remove_from_group("army_textures")
		print("processing battle")
		var animated_sprite = animated_sprites[i]
		character_instance.add_child(animated_sprite.instantiate())
		
		add_child(character_instance)
	
	characters = get_tree().get_nodes_in_group("characters")
	if characters.size() > 0:
		for character in characters:
			character.deactivate()
		set_active_character(characters[0])

func _input(event):
	if event.is_action_pressed("ui_select"):
		select_next_character()

func set_active_character(character):
	if active_character:
		active_character.deactivate()
	active_character = character
	active_character.activate()

func select_next_character():
	if characters.size() > 1:
		var index = characters.find(active_character)
		index = (index + 1) % characters.size()
		set_active_character(characters[index])
