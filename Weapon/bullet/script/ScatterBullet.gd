extends BaseBullet

var c_damage = 5
var c_speed = 1000
var num_pellet = 10
func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)



func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	var random
	if get_tree().get_first_node_in_group("player").can_crit:
		random = RandomNumberGenerator.new().randi_range(1, 5)
	if  area.has_method("TakingDamageForOther"):
		area.TakingDamageForOther(damage if random != 1 else damage * 2, true if area.get_name() == "Back" else false)
		if random == 1:
			print("crit")
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_node("../../../../../../../Level").add_child(new_label)
			new_label.position = position
		for n in num_pellet:
			var random_no =  RandomNumberGenerator.new().randi_range(0, num_pellet)
			var pellet = preload("res://Weapon/bullet/ScatterPellet.tscn")
			var new_pellet = pellet.instantiate() 
			new_pellet.position = area.global_position
			new_pellet.rotation = global_rotation + random_no
			get_parent().call_deferred("add_child", new_pellet)
	queue_free()
