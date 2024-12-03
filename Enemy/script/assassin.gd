extends Enemy


var sHealth:int = 3
var sSpeed: float = 350
var sDamage: float = 1
var sArmor : float = 1
var sFameAmount : float = 1
var wind_up_time : bool =  2
var sCurrency : int = 3

func _init():
	super._init(sHealth, sSpeed, sDamage, sArmor,sFameAmount, sCurrency)
	

	
func _physics_process(delta):
	if playerHitBox != null: 
		sprite.show()
	else:
		sprite.hide()
	super._physics_process(delta)
	
	
func AttackPlayer():
	$Attack.show()
	$Attack.get_child(1).play("attack",-1,2)
	%AttackWindup.start(2)

func PlayerLeft():
	$Attack.hide()
	inRange = false
	playerHitBox = null
	$Attack.get_child(2).stop()


func _on_attack_area_entered(area):
	if(area != null && playerHitBox != null):
		playerHitBox.TakingDamageForPlayer(-sDamage, true if playerHitBox.get_name() == "Back" else false, self)
	


func _on_footstep_timer_timeout():
	if animation_player.current_animation == "run":
		if round(animation_player.current_animation_position) < 6 :
			var footprint = preload("res://Sprite/Footstep.tscn")
			var real_footprint = footprint.instantiate()
			var texture : Texture2D = preload("res://resource/v1.1 dungeon crawler 16X16 pixel pack/effects (new)/enemy_afterdead_explosion_anim_f0.png")
			real_footprint.set_texture(texture) 
			real_footprint.emitting = true
			real_footprint.position = global_position
			get_parent().add_child(real_footprint)
