extends Interactalbe

var damage = 0
var shoot_flag = true

@onready var attack_range : CollisionShape2D = %AttackRange
	

func Interaction():
	super()
	attack_range.disabled = false
	

func _on_area_entered(area):
	pass
