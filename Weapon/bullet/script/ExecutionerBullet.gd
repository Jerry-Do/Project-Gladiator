extends BaseBullet

var c_damage = 10
var c_speed = 1800

func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)
	
func _on_area_entered(area):
	var random
	if get_node("../../../../../../Player").can_crit:
		random = RandomNumberGenerator.new().randi_range(1, 5)
	if area.has_method("TakingDamageForOther"):
		#the bracket checks if the bullet crits or not and after if the bullet hit behind enemy then it will add extra damage
		var actual_damage = ( damage if random != 1 else damage * 2 ) + 5 if area.get_name() == "Back" else 0
		area.TakingDamageForOther(actual_damage, true if area.get_name() == "Back" else false)
		if area.get_parent().health <= 0:
			get_parent().get_parent().get_parent().can_use_ability = true
			get_parent().get_parent().get_parent().cooldown_timer.stop()
		if random == 1:
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_node("../../../../../../../Level").add_child(new_label)
			new_label.position = position	
	queue_free()
