extends MoveCharger


var still_stun : bool = true
# Called when the node enters the scene tree for the first time.
func enter():
	super()
	parent.position = parent.position
	%StunTimer.start()

func exit():
	super()
	print("exit")
	parent.PlayerLeft()
	
func process_physics(_delta: float) -> State:
	if still_stun == false:
		return move_state
	if parent.health <= 0:
		return dead_state
	return null

func _on_stun_timer_timeout():
	still_stun = false
