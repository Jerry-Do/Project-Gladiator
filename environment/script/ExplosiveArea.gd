extends Area2D


func _on_area_entered(area):
	var is_player = null
	if area.has_method("TakingDamageForOther"):
		area.TakingDamageForOther(10, false, area.get_parent().faction, false)
	if  area.has_method("TakingDamageForPlayer"):
		area.TakingDamageForPlayer(-10, false, null)
	if area.name == "OilZone":
		area.SetOilOnFire()
		
func SetOilOnFire():
	null
