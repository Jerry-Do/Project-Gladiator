extends EnvironmentProps
class_name HardProps

@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var timer : Timer = $Timer

func SetCollisionShapeDisabled():
	collision_shape.disabled = true
	timer.start()
	
func _on_timer_timeout():
	collision_shape.disabled = false
