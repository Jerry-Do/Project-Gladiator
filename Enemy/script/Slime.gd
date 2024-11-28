extends Enemy


var sHealth:int = 1
var sSpeed: float = 250
var sDamage: float = 1
var sArmor : float = 2
var sFameAmount : float = 1
var wind_up_time : bool =  2


func _init():
	super._init(sHealth, sSpeed, sDamage, sArmor, sFameAmount)
	

	
func _physics_process(delta):
	super._physics_process(delta)

func AttackPlayer():
	playerHitBox.TakingDamageForPlayer(-sDamage, true if playerHitBox.get_name() == "Back" else false)
	%AttackWindup.start(2)

func PlayerLeft():
	inRange = false
	playerHitBox = null
