extends DestructableProps
@export var drop_array : DropArray
func DestroyProp():
	randomize()
	var random_no = randi_range(0,drop_array.drop_array.size() - 1)
	var drop = load(drop_array.drop_array[random_no])
	var real = drop.instantiate()
	real.position = position
	real.rotation = rotation
	get_parent().call_deferred("add_child", real)
	queue_free()
