extends Area2D
class_name BackHitbox

func TakingDamageForPlayer(amount, is_backshot):
	get_parent().MinusHealth(amount,is_backshot)

func SetStatusPlayer(name : String, duration : float):
	get_parent().SetStatusTrue(name, duration)
