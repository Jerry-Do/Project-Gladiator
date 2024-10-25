extends Area2D
class_name BackHitbox

func TakingDamageForPlayer(amount, is_backshot):
	get_parent().MinusHealth(amount,is_backshot)

func SetStatusPlayer(s_name : String, duration : float):
	get_parent().SetStatusTrue(s_name, duration)
