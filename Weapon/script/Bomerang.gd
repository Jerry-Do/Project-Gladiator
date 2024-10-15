

extends Weapon


var _cMaxAmmo = 1
var _cRateOfFire = 1
var _cReloadTime = 99999999
func _init():
	var description = "Throws a bomerang that comes back to the player, damaging everyting on the way"
	var w_name = "Bomerang"
	super._init("res://Weapon/bullet/BomerangBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name)
	
func _process(delta):
	super._process(delta)	

func shoot():
	if(currentAmmo > 0 && shootFlag):
		var BULLET = load(self.bulletName)
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %Shootingpoint.global_position
		new_bullet.global_rotation = %Shootingpoint.global_rotation
		add_child(new_bullet)
		currentAmmo -=1
		shootFlag = false
		sprite.set_visible(false)
		$Cooldown.start(self.rateOfFire)
