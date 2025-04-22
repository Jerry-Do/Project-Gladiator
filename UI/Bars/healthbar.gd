
extends ProgressBar

@onready var timer = $Timer
@onready var damageBar = $DamageBar
@onready var shield_bar = $ShieldBar
var health = 0 : set = _set_health
var shield = 0 : set = _set_shield

func _set_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	if health < prev_health:
		timer.start()
	else:
		damageBar.value = health

func init_health(_health):
	health = _health
	max_value = _health 
	value = health
	damageBar.max_value = health
	damageBar.value = health


func _on_timer_timeout():
	damageBar.value = health

func init_shield(_shield):
	shield = _shield
	shield_bar.max_value = _shield
	shield_bar.value = shield
	
func _set_shield(value):
	var _prev_shield = shield
	shield = min(shield_bar.max_value, value)
	shield_bar.value = shield
