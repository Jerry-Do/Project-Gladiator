extends State

@export 
var move_state : State

@export 
var dead_state: State

@export
var stun_state: State

func enter() -> void:
	super()
	parent.inRange = true
	parent.speed = 0
	%AttackWindup.start(2)


func process_physics(_delta: float) -> State:
	print(parent.inRange)
	if parent.health <= 0:
		return dead_state
	if parent.inRange == false:
		return move_state
	return null
	
func _on_attack_windup_timeout():
	if parent.inRange:
		print("hit")
		parent.playerHitBox.TakingDamageForPlayer(-parent.sDamage, true if parent.playerHitBox.get_name() == "Back" else false)
		%AttackWindup.start(2)


func _on_attack_range_area_exited(area):
	parent.inRange = false
	parent.playerHitBox = null
