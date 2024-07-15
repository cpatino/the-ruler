# Script en el nodo principal
extends Node2D

@onready var turn_control: Control = $Control

var army:Array[ArmyCharacterBody2D] = []
var active_character = null

var player_turn: bool = true
var max_turns: int = 20
var current_turn: int = 0

func _ready():
	load_army("res://scenes/army/archer.tscn", Vector2(100, 40))
	load_army("res://scenes/army/cavalry.tscn", Vector2(140, 40))
	load_army("res://scenes/army/general.tscn", Vector2(180, 40))
	load_army("res://scenes/army/infantry.tscn", Vector2(220, 40))
	load_army("res://scenes/army/knight.tscn", Vector2(260, 40))
	load_army("res://scenes/army/spearman.tscn", Vector2(300, 40))
	
	set_active_character(army[0])
	turn_control.hide()

func load_army(soldier_scene:String, soldier_position:Vector2):
	var soldier = load(soldier_scene).instantiate()
	soldier.position = soldier_position
	soldier.set_active(false)
	get_node("Grid").add_child(soldier)
	army.append(soldier)
	soldier.end_turn.connect(_on_end_turn)

func _process(_delta):
	if current_turn < max_turns:
		if not player_turn:
			update_turn_control()
			army.all(restart)
			set_active_character(army[0])
			player_turn = true
		else:
			turn_control.hide()
	else:
		$Control/CenterContainer/Label.set_text("Termino la batalla")
		turn_control.show()

func restart(character:ArmyCharacterBody2D):
	character.restart()
	return true

func _input(event):
	if player_turn and event.is_action_pressed("ui_select"):
		select_next_character()

func select_next_character():
	var remaining_army = army.filter(remaining_turns)
	print(remaining_army.size())
	if remaining_army.size() >= 1:
		var index = remaining_army.find(active_character)
		index = (index + 1) % remaining_army.size()
		var character = remaining_army[index]
		if not character.is_in_waiting():
			set_active_character(character)
	else:
		player_turn = false
		update_turn_control()

func remaining_turns(character: ArmyCharacterBody2D):
	return not character.is_in_waiting()

func set_active_character(character: ArmyCharacterBody2D):
	if active_character:
		active_character.set_active(false)
	active_character = character
	active_character.set_active(true)
	$SoldierCamera2D.character = active_character

func update_turn_control():
	current_turn += 1
	$Control/CenterContainer/Label.set_text("Termino el turno " + str(current_turn))
	turn_control.show()

func _on_end_turn():
	select_next_character()
