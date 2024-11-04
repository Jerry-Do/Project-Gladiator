extends Interactalbe

var damage = 0
var shoot_flag = true

@onready var interaction_range : CollisionShape2D = %InteractionRange
@onready var attack_range : CollisionShape2D = %AttackRange
@onready var aim : Marker2D = %Marker2D
var target : Node = null
var targets : Array
	

func Interaction():
	super()
	attack_range.disabled = false
	$Downtime.start()

func _on_downtime_timeout():
	#if interacted:
		#target = get_tree().get_first_node_in_group("enemy")
		#if target != null:
			#aim.set_rotation(get_angle_to(target.global_position))
			#var BULLET = preload("res://Weapon/bullet/BotBullet.tscn")
			#var new_bullet = BULLET.instantiate()
			#new_bullet.global_position = aim.global_position
			#new_bullet.global_rotation = aim.global_rotation
			#get_parent().add_child(new_bullet)
	if interacted:
		if targets.is_empty() != true:
			aim.set_rotation(get_angle_to(targets.front().global_position))
			var BULLET = preload("res://Weapon/bullet/BotBullet.tscn")
			var new_bullet = BULLET.instantiate()
			new_bullet.global_position = aim.global_position
			new_bullet.global_rotation = aim.global_rotation
			get_parent().add_child(new_bullet)
		


func _on_attack_range_area_entered(area):
	if area.has_method("TakingDamageForOther"):
		targets.append(area)


func _on_attack_range_area_exited(area):
	if area.has_method("TakingDamageForOther"):
		targets.erase(area)
