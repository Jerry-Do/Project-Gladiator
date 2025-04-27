extends DestructableProps

var is_on_fire : bool = false

	
func DestroyProp():
	var oil_zone = preload("res://environment/Oil.tscn")
	var real = oil_zone.instantiate()
	real.global_position = global_position
	get_parent().call_deferred("add_child", real)
	queue_free()
	
