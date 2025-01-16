extends Weapon

class_name MachineGun
var _cMaxAmmo = 30
var _cRateOfFire = 0.15
var _cReloadTime = 3
var _cFaction = "tech"
func _init():
	var description = "Just a machinegun"
	var w_name = "Machinegun"
	super._init("res://Weapon/bullet/bullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name, _cFaction)
	
func _process(delta):
	super._process(delta)	

func shoot():
	if(currentAmmo > 0 && shootFlag):
		var BULLET = load(self.bulletName)
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %Shootingpoint.global_position
		new_bullet.global_rotation = %Shootingpoint.global_rotation
		new_bullet.faction = _cFaction
		player.get_parent().add_child(new_bullet)
		currentAmmo -=1
		shootFlag = false
		StartCooldownTimer()
