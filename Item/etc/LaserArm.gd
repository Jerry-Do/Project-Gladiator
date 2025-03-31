extends Area2D

@export var max_fuel : float = 0

var recharge_flag
var damage = 1
var player_flag : bool = false
var no_times_getting_hit : int = 0
var lock_on_targets : Array
var real = null
var is_on_cd : bool = false
var fuel : float = 5.0
	
		

func _physics_process(delta):
	if lock_on_targets.is_empty() != true && real != null :
		#look_at(lock_on_targets.front().get_parent().position)
		var distance = global_position.distance_to(lock_on_targets.front().global_position)
		real.set_point_position( 1,real.to_local(lock_on_targets.front().get_parent().global_position))
		fuel = clampi(fuel - delta, 0, fuel - delta)
	if lock_on_targets.is_empty() && real != null:
		real.queue_free()
		real = null
	if fuel != max_fuel:
		fuel = clampf(fuel + delta, fuel + delta, max_fuel)
		recharge_flag = true
	if fuel >= max_fuel:
		recharge_flag = false
func _on_area_entered(area):
	if area.has_method("TakingDamageForOther") && fuel > 0 && recharge_flag == false:
		lock_on_targets.append(area)
		if lock_on_targets.is_empty() != true && real == null:
			var laser = preload("res://Item/etc/Laser.tscn")
			real = laser.instantiate()
			real.damage = damage
			real.add_point(real.position)
			real.add_point(real.to_local(lock_on_targets.front().get_parent().global_position), 1)
			call_deferred("add_child", real)
		


func _on_area_exited(area):
	if area.has_method("TakingDamageForOther"):
		lock_on_targets.erase(area)



	
