extends Interactable

var success : bool = false
var done : bool = false
func Interaction():
	super()
	%Border.disabled = false
	$Timer.start(5)

func _process(delta):
	if interacted && done == false:
		var actualString =  "%d" % $Timer.time_left 
		$TimerLabel.text = "Time: " + actualString
		
		

func _on_border_area_exited(area):
	if success == false:
		$Timer.stop()
		$TimerLabel.text = "Objective Failed"
		done = true

func _on_timer_timeout():
	success = true
	game_manager.AdjustCurrency(50)
	$TimerLabel.text = "Objective Completed"
	done = true
		
