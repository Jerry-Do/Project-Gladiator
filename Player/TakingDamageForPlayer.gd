extends Area2D
class_name BackHitbox

func TakingDamageForPlayer(amount, is_backshot):
	if get_parent().invincibleState == false:
		get_parent().MinusHealth(amount,is_backshot)

func SetStatusPlayer(s_name : String, duration : float):
	if get_parent().invincibleState == false:
		get_parent().SetStatusTrue(s_name, duration)
