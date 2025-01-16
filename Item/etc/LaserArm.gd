extends Area2D

var damage = 10
var player_flag = false
var no_times_getting_hit = 0
var lock_on_targets : Array
var real = null

func _on_timer_timeout():
	pass
	
	
		

func _physics_process(delta):
	if lock_on_targets.is_empty() != true && real != null :
		#look_at(lock_on_targets.front().get_parent().position)
		var distance = global_position.distance_to(lock_on_targets.front().global_position)
		real.set_point_position( 1,real.to_local(lock_on_targets.front().get_parent().global_position))
	if lock_on_targets.is_empty() && real != null:
		real.queue_free()
		real = null
		
func _on_area_entered(area):
	if area.has_method("TakingDamageForOther"):
		lock_on_targets.append(area)
		if lock_on_targets.is_empty() != true:
			var laser = preload("res://Item/etc/Laser.tscn")
			real = laser.instantiate()
			real.damage = damage
			real.add_point(real.position)
			real.add_point(real.to_local(lock_on_targets.front().get_parent().global_position), 1)
			call_deferred("add_child", real)
		


func _on_area_exited(area):
	if area.has_method("TakingDamageForOther"):
		lock_on_targets.erase(area)



	
