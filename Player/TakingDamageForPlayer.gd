extends Area2D
class_name BackHitbox

signal getting_hit(attacker, amount : float)

func TakingDamageForPlayer(amount: float, is_backshot: bool, attacker):
	if get_parent().invincibleState == false:
		get_parent().MinusHealth(amount,is_backshot)
		getting_hit.emit(attacker, amount)
		

func SetStatusPlayer(s_name : String, duration : float):
	if get_parent().invincibleState == false:
		get_parent().SetStatusTrue(s_name, duration)
