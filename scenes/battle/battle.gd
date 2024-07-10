# Script en el nodo principal
extends Node2D

var army = []
var active_character = null

func _ready():
	load_army("res://scenes/army/archer.tscn", Vector2(100, 40))
	load_army("res://scenes/army/cavalry.tscn", Vector2(140, 40))
	load_army("res://scenes/army/general.tscn", Vector2(180, 40))
	load_army("res://scenes/army/infantry.tscn", Vector2(220, 40))
	load_army("res://scenes/army/knight.tscn", Vector2(260, 40))
	load_army("res://scenes/army/spearman.tscn", Vector2(300, 40))
	
	set_active_character(army[0])

func load_army(soldier_scene:String, soldier_position:Vector2):
	var soldier = load(soldier_scene).instantiate()
	soldier.position = soldier_position
	soldier.set_active(false)
	get_node("Grid").add_child(soldier)
	army.append(soldier)
	soldier.end_turn.connect(_on_end_turn)

func _input(event):
	if event.is_action_pressed("ui_select"):
		select_next_character()

func select_next_character():
	if army.size() > 1:
		var index = army.find(active_character)
		index = (index + 1) % army.size()
		var character = army[index]
		if not character.is_turn_ended():
			set_active_character(character)

func set_active_character(character):
	if active_character:
		active_character.set_active(false)
	active_character = character
	active_character.set_active(true)
	$SoldierCamera2D.character = active_character

func _on_end_turn():
	select_next_character()
