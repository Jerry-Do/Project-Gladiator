
extends Weapon


var _cMaxAmmo = 4
var _cRateOfFire = 1.25
var _cReloadTime = 2

func _init():
	super._init("res://Weapon/bullet/ExecutionerBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime)
	
func _process(delta):
	super._process(delta)	

func shoot():
	if(currentAmmo > 0 && shootFlag):
		var BULLET = load(self.bulletName)
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %Shootingpoint.global_position
		new_bullet.global_rotation = %Shootingpoint.global_rotation
		%Shootingpoint.add_child(new_bullet)
		currentAmmo -=1
		shootFlag = false
		$Cooldown.start(self.rateOfFire  if game_manager.timeSlowFlag == false else self.rateOfFire * 0.25)
		
#func UseGunAbility():
	#if player != null:
		#player.is_invisible = true
		#player.animated_sprite.set_self_modulate(Color(1,1,1,0))
#
#
#func _on_duration_timeout():
	#if player != null:
		#player.is_invisible = false