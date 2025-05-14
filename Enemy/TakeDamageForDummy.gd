extends Area2D
var hit_by_lightning : bool = false
func TakingDamageForOther(amount, is_backshot, faction, crit):
	#queue_free()
	pass
	
func SetStatus(type: String, duration: float):
	pass

func HitByLightning():
	hit_by_lightning = true
	await  get_tree().create_timer(0.25).timeout
	hit_by_lightning = false
