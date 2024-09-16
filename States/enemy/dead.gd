extends State


func process_physics(delta: float):
	var level = get_node("/root/Game/Level")
	level.AdjustFame(parent.fameAmount)
	level.IncreaseKillCount()
	parent.spawner.OnEnemyKilled()
	parent.queue_free()
	
