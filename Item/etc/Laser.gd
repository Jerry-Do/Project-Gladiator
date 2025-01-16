extends Line2D
@export var damage = 1
@export var damage_interval = 0.25
@onready var collision_shape = %CollisionShape2D
var targets : Array
var d = 0
func _physics_process(delta):
	d += delta
	collision_shape.shape.a = get_point_position(0)
	collision_shape.shape.b = get_point_position(1)
	for target in targets:
		if d >= damage_interval:
			target.TakingDamageForOther(damage, false, "tech", false)
			d = 0
			

func _on_area_2d_area_entered(area):
	targets.append(area)


func _on_area_2d_area_exited(area):
	targets.erase(area)
