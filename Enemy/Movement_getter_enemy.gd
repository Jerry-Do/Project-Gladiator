extends Node
var parent = get_parent()

func get_movement_direction():
	MakePath()
	
func MakePath():
	if parent.player != null:
		parent.navAgent.target_position = parent.player.global_position
		##$AnimatedSprite2D.play("run")
		##if(parent.player.position.x - parent.position.x) < 0:
		##	$AnimatedSprite2D.flip_h = true
		##else:
			##$AnimatedSprite2D.flip_h = false
	##else:
		##$AnimatedSprite2D.play("idle")
