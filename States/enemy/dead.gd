extends State


func process_physics(delta: float):
	parent.OnDead()
	parent.game_manager.AdjustKill(1)
	parent.game_manager.AdjustFame(parent.fameAmount)
	parent.game_manager.enemy_spawner.OnEnemyKilled()
	parent.queue_free()
	
