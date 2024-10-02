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
