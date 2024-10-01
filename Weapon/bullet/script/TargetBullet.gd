extends BaseBullet

var c_damage = 0
var c_speed = 1000


func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)


func _on_body_entered(body):
	if body.has_method("SetTarget"):
		body.SetTarget()
	queue_free()
