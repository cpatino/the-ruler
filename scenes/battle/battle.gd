# Script en el nodo principal
extends Node2D

@export var character_scene: PackedScene

var characters = []
var soldier_scenes = []
var active_character = null

func _ready():
	soldier_scenes.append(load("res://scenes/army/infantry.tscn"))
	
	var infantry = soldier_scenes[0].instantiate()
	infantry.position = Vector2(100, 40)
	set_active_character(infantry)
	add_child(infantry)
	characters.append(infantry)
	
	soldier_scenes.append(load("res://scenes/army/knight.tscn"))
	var knight = soldier_scenes[1].instantiate()
	knight.position = Vector2(180, 40)
	knight.deactivate()
	add_child(knight)
	characters.append(knight)

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
