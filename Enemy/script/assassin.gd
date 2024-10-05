extends Enemy


var sHealth:int = 1
var sSpeed: float = 500
var sDamage: float = 1
var sFameAmount : float = 1
var wind_up_time : bool =  2


func _init():
	super._init(sHealth, sSpeed, sDamage, sFameAmount)
	

	
func _physics_process(delta):
	super._physics_process(delta)

func AttackPlayer():
	sprite.show()
	position = ( playerHitBox.get_parent().back_hitbox.get_child(0).global_position - Vector2(60 *  playerHitBox.get_parent().scale.y,0))
	$Attack.show()
	$Attack.get_child(1).play("attack")
	%AttackWindup.start(2)

func PlayerLeft():
	sprite.hide()
	$Attack.hide()
	inRange = false
	playerHitBox = null
	$Attack.get_child(2).stop()


func _on_attack_area_entered(area):
	playerHitBox.TakingDamageForPlayer(-sDamage, true if playerHitBox.get_name() == "Back" else false)
	
