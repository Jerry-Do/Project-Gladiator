class_name HitboxOther
extends Area2D
var hit_by_lightning : bool = false

func TakingDamageForOther(amount, is_backshot, faction, crit):
	return get_parent().MinusHealth(amount,is_backshot, faction, crit)
	
func SetStatusOther(s_name : String, duration : float):
	get_parent().SetStatusTrue(s_name, duration)

func SetBuffForEnemy(b_name: String, duration : float):
	get_parent().SetBuffTrue(b_name, duration)

func _on_body_entered(body):
	if body.has_method("SetCollisionShapeDisabled"):
		body.call_deferred("SetCollisionShapeDisabled")
		get_parent().SetStatusTrue("stun", 1)
	
func SetStatus(s_name : String, duration : float):
	SetStatusOther(s_name, duration)

func _on_area_entered(area):
	if area.has_method("TakingDamageForPlayer"):
		area.TakingDamageForPlayer(-get_parent().stats_dic["damage"],false,self)

func HitByLightning():
	hit_by_lightning = true
	await  get_tree().create_timer(0.25).timeout
	hit_by_lightning = false
