extends Enemy


var sHealth:int = 1
var sSpeed: float = 1000
var sDamage: float = 1
var sFameAmount : float = 1
var wind_up_time : bool =  2


func _init():
	super._init(sHealth, sSpeed, sDamage, sFameAmount)
	

	
func _physics_process(delta):
	super._physics_process(delta)

func AttackPlayer():
	speed = 0
	await get_tree().create_timer(2).timeout
	speed = sSpeed * 2
	var direction = (player.position - position).normalized()
	position += direction * 100
	#%AttackWindup.start(2)

func PlayerLeft():
	inRange = false
	playerHitBox = null
