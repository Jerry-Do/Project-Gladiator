extends Enemy


var sHealth:int = 1
var sSpeed: float = 1000
var sDamage: float = 5
var sFameAmount : float = 1
var wind_up_time : bool =  2

func _init():
	super._init(sHealth, sSpeed, sDamage, sFameAmount)
	

	
func _physics_process(delta):
	super._physics_process(delta)

func PlayerLeft():
	inRange = false
	playerHitBox = null



	