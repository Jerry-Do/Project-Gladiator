extends BaseBullet

var c_damage = 3
var c_speed = 1000
var shooter
func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)
	
func _on_area_entered(area):
	var random = RandomNumberGenerator.new().randi_range(1, 10)
	if area.has_method("TakingDamageForPlayer")  :
		area.TakingDamageForPlayer(-damage if random != 1 else -damage * 2, true if area.get_name() == "Back" else false,shooter if get_parent() != null else null)
		game_manager.AdjustFame(-(game_manager.currentFame * 0.10))
		queue_free()
	if area.has_method("DestroyProp"):
		area.DestroyProp()

func _on_ghost_timer_timeout():
	if game_manager.timeSlowFlag:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		add_child(this_ghost)
		this_ghost.position = position
		this_ghost.texture = sprite.texture
		this_ghost.flip_h = sprite.flip_h
		this_ghost.scale = scale
		this_ghost.rotation = rotation
