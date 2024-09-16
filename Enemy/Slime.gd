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

func _on_attack_range_body_entered(body):
	playerHitBox = body
	playerHitBox.MinusHealth(-1)
	if body.has_method("MinusHealth"):
		inRange = true
		speed = 0
		$AttackWindup.start(2)


func _on_attack_range_body_exited(body):
	inRange = false
	speed = sSpeed


func _on_attack_windup_timeout():
	if inRange:
		playerHitBox.MinusHealth(-sDamage)
