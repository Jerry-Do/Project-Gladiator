class_name HitboxOther
extends Area2D


func TakingDamageForOther(amount, is_backshot):
	return get_parent().MinusHealth(amount,is_backshot)
	
func SetStatusOther(s_name : String, duration : float):
	get_parent().SetStatusTrue(s_name, duration)
