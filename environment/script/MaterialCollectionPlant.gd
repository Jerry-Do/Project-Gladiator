extends Interactable

@export var required_amount : int = 0
var enemies : Array = []
#@onready var player = get_tree().get_first_node_in_group("player")
var success : bool = false
var done : bool = false
var amount : int = 0
func Interaction():
	super()
	%Border.disabled = false
	$Timer.start(10)

func _process(delta):
	if interacted && done == false:
		var actualString =  "%d" % $Timer.time_left 
		$TimerLabel.text = "Time: " + actualString
		
		

func _on_border_area_exited(area):
	if area.get_parent().has_method("MinusHealth"):
		enemies.erase(area)
		area.get_parent().OnKilled.disconnect(self.EnemyKilled)

func _on_timer_timeout():
	get_tree().get_first_node_in_group("player").stats.SetHealth(required_amount - amount)
	get_tree().get_first_node_in_group("player").stats.LevelUp()
	$TimerLabel.text = "Objective Completed"
	$AmountLabel.queue_free()
	done = true
		


func _on_border_area_entered(area):
	if area.get_parent().has_method("MinusHealth"):
		enemies.append(area)
		if area.get_parent().OnKilled.is_connected(self.EnemyKilled) == false:
			area.get_parent().connect("OnKilled", self.EnemyKilled)

func EnemyKilled():
	amount += 1
	$AmountLabel.text = "Amount: " + str(amount)
	if amount >= required_amount:
		$Timer.timeout
