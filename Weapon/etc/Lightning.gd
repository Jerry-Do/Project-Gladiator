extends Line2D
#Fix: shooting at an angle the second target will be scan before the intial target
var targets : Array
var hit_id : int = 0
var crit_flag : bool = false
var bullet_parent : BaseBullet = null
signal OnKill
func Init(initial_pos: Vector2, id : int, crit: bool, parent : BaseBullet):
	hide()
	connect("OnKill", bullet_parent.OnLightningKills)
	var amount : float = parent.player.stats.ReturnSpeed() + (parent.player.stats.ReturnSpeed() * 0.01) 
	parent.player.stats.SetSpeed(amount)
	crit_flag = crit
	add_point(initial_pos,0)
	targets.append(hit_id)
	%HitShape.shape.a = get_point_position(0)
	bullet_parent = parent
	hit_id = id
	add_point(initial_pos + Vector2(10,0),1)
	%HitShape.shape.b = get_point_position(1)
	%DetectionShape.position = get_point_position(1)
	


func _on_detection_range_area_entered(area):	
	if area.has_method("TakingDamageForOther"):
		show()
		if area.get_instance_id() != hit_id && area.hit_by_lightning == false:
			hit_id = area.get_instance_id()
			targets.append(area)
			remove_point(1)
			add_point(to_local(targets[1].global_position),1)
			%HitShape.shape.b = get_point_position(1)
		


func _on_timer_timeout():
	queue_free()


func _on_hit_line_area_entered(area):
	if area.has_method("TakingDamageForOther") && area.hit_by_lightning == false:
		if bullet_parent.weapon_parent.upgrade_chosen == "Stun Lightning":
			area.SetStatus("stun",0.25)
		if area.TakingDamageForOther(2, false, "tech", crit_flag) <= 0:
			OnKill.emit()
		area.HitByLightning()
		var lightning = preload("res://Weapon/etc/Lightning.tscn")
		var real = lightning.instantiate()
		get_tree().get_first_node_in_group("GameManager").get_parent().call_deferred("add_child", real)
		real.Init(real.to_local(area.global_position), area.get_instance_id(),crit_flag, bullet_parent)
