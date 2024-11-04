
extends Weapon


var _cMaxAmmo = 10
var _cRateOfFire = 0.1
var _cReloadTime = 1.5
var restore_health_mode = false

func _init():
	var description = "Consumes health to deal increase damage, right click to switch mode to restore health instead"
	var w_name = "Bloodgun"
	super._init("res://Weapon/bullet/BloodBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name)
	
func _process(delta):
	super._process(delta)	

func shoot():
	var BULLET = null
	if restore_health_mode == false:
		BULLET = preload("res://Weapon/bullet/BloodBullet.tscn")
		player.SetHealth(-1)
	else:
		BULLET = preload("res://Weapon/bullet/RestoreBloodBullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %Shootingpoint.global_position
	new_bullet.global_rotation = %Shootingpoint.global_rotation
	%Shootingpoint.add_child(new_bullet)	
	shootFlag = false
	$Cooldown.start(self.rateOfFire  if game_manager.timeSlowFlag == false else self.rateOfFire * 0.25)
		
func UseGunAbility():
	restore_health_mode = true
