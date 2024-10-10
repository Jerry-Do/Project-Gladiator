class_name HitboxOther
extends Area2D


func TakingDamageForOther(amount, is_backshot):
	return get_parent().MinusHealth(amount,is_backshot)
