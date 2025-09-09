extends Area2D

var c_damage = 3
var c_speed = 500
var shooter
var travelled_dist : float = 0
var RANGE = 1000

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * c_speed * delta
	travelled_dist += c_speed * delta
	if travelled_dist > RANGE:
		queue_free()
	
func _on_area_entered(area):
	var random = RandomNumberGenerator.new().randi_range(1, 10)
	if area.has_method("TakingDamageForPlayer")  :
		area.TakingDamageForPlayer(-c_damage  if random != 1 else -c_damage  * 2, true if area.get_name() == "Back" else false,shooter if get_parent() != null else null)
		GameManager.instance.AdjustFame(-(GameManager.instance.currentFame * 0.10))
		queue_free()	
	if area.has_method("DestroyProp"):
		area.DestroyProp()
		queue_free()	
	

func _on_ghost_timer_timeout():
	if GameManager.instance.timeSlowFlag:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		add_child(this_ghost)
		this_ghost.position = position
		this_ghost.texture = $Bullet.texture
		this_ghost.flip_h = $Bullet.flip_h
		this_ghost.scale = scale
		this_ghost.rotation = rotation
