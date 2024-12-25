extends Interactable

@export var base_required_amount : int = 0
var enemies : Array = []
@onready var player = get_tree().get_first_node_in_group("player")
var success : bool = false
var done : bool = false
var amount : int = 0
func Interaction():
	super()
	%Border.disabled = false
	$Timer.start(15)

func _process(delta):
	if interacted && done == false:
		var actualString =  "%d" % $Timer.time_left 
		$TimerLabel.text = "Time: " + actualString
		
		


func _on_timer_timeout():
	player.stats.SetHealth(-(base_required_amount * game_manager.currentWave - amount))
	var random_no = randi_range(1,3)
	var text = ""
	match random_no:
		1:
			player.stats.SetBaseDamageMod(1 * (game_manager.currentWave / 2.0))
			text = "Base damage mod increased"
		2:
			player.stats.SetHealth( 1 * (game_manager.currentWave / 2.0))
			player.stats.maxHealth += 1 * (game_manager.currentWave / 2.0)
			text = "Max health increased"
		3:
			player.stats.SetBaseArmorMod(1 * (game_manager.currentWave / 2.0))
			text = "Base armor increased"
	$TimerLabel.text = text
	$AmountLabel.hide()
	done = true
		


func _on_border_area_entered(area):
	if area.get_parent().has_method("MinusHealth"):
		enemies.append(area)
		if area.get_parent().OnDeath.is_connected(self.EnemyKilled) == false:
			area.get_parent().connect("OnDeath", self.EnemyKilled)

func EnemyKilled(enemy):
	enemies.erase(enemy)
	amount += 1
	$AmountLabel.text = "Enemy Killed: " + str(amount)
	if amount >= (base_required_amount * game_manager.currentWave):
		$Timer.emit_signal("timeout")


func _on_border_area_exited(area):
	enemies.erase(area)
