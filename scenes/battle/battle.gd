# Script en el nodo principal
extends Node2D

@onready var turn_control: Control = $Control

const SOLDIER_SCENE: String = "res://scenes/army/soldier.tscn"
const ENEMY_SCENE: String = "res://scenes/enemy/enemy.tscn"

var army: Array[ArmyCharacterBody2D] = []
var active_character = null

var enemy_array: Array[EnemyArea2D] = []

var player_turn: bool = true
var max_turns: int = 20
var current_turn: int = 0

func _ready():
	load_army("res://scenes/army/sprites/archer.tscn", Vector2(100, 40), 3)
	#load_army("res://scenes/army/sprites/cavalry.tscn", Vector2(140, 40), 7)
	#load_army("res://scenes/army/sprites/general.tscn", Vector2(180, 40), 5)
	#load_army("res://scenes/army/sprites/infantry.tscn", Vector2(220, 40), 4)
	#load_army("res://scenes/army/sprites/knight.tscn", Vector2(260, 40), 4)
	#load_army("res://scenes/army/sprites/spearman.tscn", Vector2(300, 40), 4)
	
	set_active_character(army[0])
	load_enemy("res://scenes/enemy/northern/knight.tscn", Vector2(100, 320), 3)
	update_turn_control()

func load_army(sprite_scene: String, soldier_position: Vector2, max_movements: int):
	var sprite: AnimatedSprite2D = load(sprite_scene).instantiate()
	
	var soldier: ArmyCharacterBody2D = load(SOLDIER_SCENE).instantiate()
	
	soldier.position = soldier_position
	soldier.set_active(false)
	soldier.add_child(sprite)
	
	soldier.get_sprite_player().animated_sprite = sprite
	soldier.get_grid_movement().max_movements = max_movements
	
	get_node("Grid").add_child(soldier)
	army.append(soldier)
	soldier.end_turn.connect(_on_end_turn)

func load_enemy(sprite_scene: String, init_position: Vector2, max_movements: int):
	var sprite: AnimatedSprite2D = load(sprite_scene).instantiate()
	
	var enemy_soldier: EnemyArea2D = load(ENEMY_SCENE).instantiate()
	enemy_soldier.position = init_position
	enemy_soldier.add_child(sprite)
	enemy_soldier.get_grid_movement().max_movements = max_movements
	
	get_node("Grid").add_child(enemy_soldier)
	enemy_array.append(enemy_soldier)

func _process(delta):
	if current_turn <= max_turns:
		if not player_turn:
			update_turn_control()
			enemy_array.all(func(enemy):
				return enemy_turn(enemy, delta))
			army.all(restart)
			set_active_character(army[0])
			player_turn = true
	else:
		$Control/CenterContainer/Label.set_text("Termino la batalla")
		turn_control.show()

func restart(character: ArmyCharacterBody2D):
	character.restart()
	return true

func enemy_turn(enemy_soldier: EnemyArea2D, _delta):
	enemy_soldier.waiting = false
	enemy_soldier.get_grid_movement().move()
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
	$Control/CenterContainer/Label.set_text("Turno " + str(current_turn) + " de 20")
	turn_control.show()

func _on_end_turn():
	select_next_character()
