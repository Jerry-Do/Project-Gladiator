extends State


func process_physics(delta: float):
	parent.game_manager.AdjustKill(1)
	parent.game_manager.AdjustFame(parent.fameAmount)
	parent.spawner.OnEnemyKilled()
	parent.queue_free()
	
