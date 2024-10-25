
extends Weapon


var _cMaxAmmo = 8
var _cRateOfFire = 0.1
var _cReloadTime = 1.5

func _init():
	var description = "Just a handgun"
	var w_name = "Handgun"
	super._init("res://Weapon/bullet/bullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name)
	
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
		
