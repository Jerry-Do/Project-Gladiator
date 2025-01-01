extends Enemy


var sHealth: int = 8
var sSpeed: float = 400
var sDamage: float = 5
var sArmor : float = 3
var sFameAmount : float = 2
var wind_up_time : bool =  2
var sCurrency : int = 5
func _init():
	super._init(sHealth, sSpeed, sDamage, sArmor, 	sFameAmount, sCurrency)
	

	
func _physics_process(delta):
	super._physics_process(delta)

func PlayerLeft():
	inRange = false
	playerHitBox = null



	
