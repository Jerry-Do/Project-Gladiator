extends Area2D
var hit_by_lightning : bool = false
func TakingDamageForOther(amount, is_backshot, faction, crit):
	#queue_free()
	pass
	


func _on_timer_timeout():
	hit_by_lightning = false
