extends Enemy


var sHealth:int = 1
var sSpeed: float = 300
var sDamage: float = 1
var sFameAmount : float = 1
var inRange: bool = false
var playerHitBox : Node2D



func _init():
	super._init(sHealth, sSpeed, sDamage, sFameAmount)
	

	
func _physics_process(delta):
	super._physics_process(delta)



func _on_attack_windup_timeout():
	if inRange:
		playerHitBox.TakingDamageForPlayer(-sDamage, true if playerHitBox.get_name() == "Back" else false)


func _on_attack_range_area_entered(area):
	playerHitBox = area
	
	if area.has_method("TakingDamageForPlayer"):
		playerHitBox.TakingDamageForPlayer(-sDamage, false)
		inRange = true
		speed = 0
		$AttackWindup.start(2)


func _on_attack_range_area_exited(area):
	inRange = false
	speed = sSpeed
