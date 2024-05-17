extends Weapon

class_name MachineGun
var _cMaxAmmo = 30
var _cRateOfFire = 0.25
var _cReloadTime = 3

func _init():
	super._init("res://Weapon/bullet/bullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime)
	
func _physics_process(delta):
	super._physics_process(delta)	

func shoot():
	if(currentAmmo > 0 && shootFlag):
		var BULLET = load(self.bulletName)
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %Shootingpoint.global_position
		new_bullet.global_rotation = %Shootingpoint.global_rotation
		%Shootingpoint.add_child(new_bullet)
		currentAmmo -=1
		shootFlag = false

		$Cooldown.start(self.rateOfFire)





