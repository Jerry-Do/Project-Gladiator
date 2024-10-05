extends Area2D


func TakingDamageForEnemy(amount, is_backshot):
	get_parent().MinusHealth(amount,is_backshot)
