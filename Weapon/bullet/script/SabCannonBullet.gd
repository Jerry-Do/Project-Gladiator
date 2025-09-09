extends BaseBullet
var c_damage = 10
var c_speed = 600

func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)
	
func _on_area_entered(area):
	if area.has_method("TakingDamageForOther"):
		queue_free()


func _on_tree_exited():
	var black_hole = preload("res://Weapon/etc/BlackHole.tscn")
	var real = black_hole.instantiate()
	real.global_position = global_position
	real.rotation = real.rotation
	real.c_damage = c_damage
	real.c_speed = c_speed
	GameManager.instance.get_parent().add_child(real)
