extends Enemy


var sHealth:int = 5
var sSpeed: float = 250
var sDamage: float = 2
var sArmor : float = 1
var sFameAmount : float = 1
var wind_up_time : bool = 5


func _init():
	super._init(sHealth, sSpeed, sDamage, sArmor ,sFameAmount)
	

	
func _physics_process(delta):
	super._physics_process(delta)
	
func AttackPlayer():
	$Attack.show()
	$Attack.get_child(2).play("explosion")
	$AttackWindup.start(wind_up_time)

func PlayerLeft():
	inRange = false
	playerHitBox = null



func _on_attack_area_entered(area):
	if area.has_method("SetStatusPlayer"):
		area.SetStatusPlayer("timeStopDisable", 8)
		area.TakingDamageForPlayer(-sDamage, true if area.get_name() == "Back" else false)
