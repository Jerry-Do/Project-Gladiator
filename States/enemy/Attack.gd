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
	parent.stats_dic.speed = 0
	%AttackWindup.start(parent.wind_up_time)


func process_physics(_delta: float) -> State:
	if parent.stats_dic.health <= 0:
		return dead_state
	if parent.inRange == false:
		return move_state
	return null
	
func _on_attack_windup_timeout():
	if parent.inRange:
		parent.Attack()


func _on_attack_range_area_exited(area):
	if area.has_method("TakingDamageForPlayer"):
		parent.PlayerLeft()
	
