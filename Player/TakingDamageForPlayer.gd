extends Area2D
class_name BackHitbox

signal getting_hit(attacker, amount : float)

@onready var player : Player = get_parent()

func TakingDamageForPlayer(amount: float, is_backshot: bool, attacker):
	if player.invincibleState == false:
		player.MinusHealth(amount,is_backshot)
		getting_hit.emit(attacker, amount)
	return 0

func SetStatusPlayer(s_name : String, duration : float):
	if player.invincibleState == false:
		player.SetStatusTrue(s_name, duration)

func SetStatus(s_name : String, duration : float):
	SetStatusPlayer(s_name, duration)

func _on_area_entered(area):
	if area.has_method("SetStatus"):
		if player.game_manager.timeSlowFlag && player.itemNode.dominant_type == "tech":
			area.SetStatus("stun",3)

func Spotlight(flag : bool):
	var amount = player.stats.ReturnDamageMod()
	player.stats.SetDamageMod(amount if flag else -amount)
	player.game_manager.is_on_spotlight = flag
