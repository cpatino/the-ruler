extends EnemyState

func enter():
	enemy.get_grid_movement().set_init_position()

func exit():
	pass

func update():
	var must_walk: bool = true
	if enemy.can_move():
		enemy.set_target_position(target)
		must_walk = enemy.must_walk()
		
		if must_walk:
			var direction = target.global_position - enemy.get_next_path_position()
			var ai_direction = direction.normalized()
			if abs(ai_direction.x) > 0 and abs(ai_direction.y) > 0:
				ai_direction.x = 0
				ai_direction.y = 1 if ai_direction.y > 0 else -1
			enemy.get_grid_movement().ai_direction = ai_direction
			enemy.get_grid_movement().move()
	
	if enemy.get_grid_movement().remaining_movements == 0 or not must_walk:
		enemy.waiting = true
		enemy.get_grid_movement().set_init_position()
		enemy.enemy_end_turn.emit()
