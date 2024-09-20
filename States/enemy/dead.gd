extends State


func process_physics(delta: float):
	
	parent.game_manager.AdjustFame(parent.fameAmount)
	parent.game_manager.IncreaseKillCount()
	parent.spawner.OnEnemyKilled()
	parent.queue_free()
	
