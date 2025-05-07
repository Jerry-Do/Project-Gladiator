extends BaseBullet

var c_damage = 0
var c_speed = 1000


func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)


func _on_area_entered(area):
	if area.get_parent().has_method("SetTarget"):
		area.get_parent().SetTarget()
		queue_free()
