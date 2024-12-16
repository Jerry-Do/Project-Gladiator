extends BaseBullet

var c_damage = 6
var c_speed = 1000
var shooter
func _init():
	super._init(c_damage, c_speed)

func _physics_process(delta):
	super._physics_process(delta)
	
func _on_area_entered(area):
	var random = RandomNumberGenerator.new().randi_range(1, 10)
	if area.has_method("TakingDamageForPlayer"):
		area.TakingDamageForPlayer(-damage if random != 1 else -damage * 2, true if area.get_name() == "Back" else false,shooter)
		game_manager.AdjustFame(-(game_manager.currentFame * 0.10))
		if random == 1:
			print("crit")
			var crit_label = preload("res://UI/Critlabel.tscn")
			var new_label = crit_label.instantiate()
			get_tree().get_first_node_in_group("player").get_parent().add_child(new_label)
			new_label.position = position
			
		queue_free()

func _on_ghost_timer_timeout():
	if game_manager.timeSlowFlag:
		var this_ghost = preload("res://Sprite/Ghost.tscn").instantiate()
		add_child(this_ghost)
		this_ghost.position = position
		this_ghost.texture = sprite.texture
		this_ghost.flip_h = sprite.flip_h
		this_ghost.scale = scale
		this_ghost.rotation = rotation
