extends Attack


func _on_attack_range_area_exited(area):
	if area.has_method("TakingDamageForPlayer"):
		parent.PlayerLeft()
	
