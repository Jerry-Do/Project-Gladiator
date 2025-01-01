extends Enemy


var sHealth:int = 5
var sSpeed: float = 250
var sDamage: float = 4
var sArmor : float = 1
var sFameAmount : float = 1
var wind_up_time : bool = 5
var sCurrency : int = 2

func _init():
	super._init(sHealth, sSpeed, sDamage, sArmor ,sFameAmount, sCurrency)
	

	
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
		area.TakingDamageForPlayer(-sDamage, true if area.get_name() == "Back" else false, self)
		game_manager.AdjustFame(-(game_manager.currentFame * 0.10))
