
extends Weapon


var _cMaxAmmo = 8
var _cRateOfFire = 0.25
var _cReloadTime = 2
var _cFaction = "biochemical"
func _init():
	var description = "If the bullet kills an enemy, it will create pellets shooting out in random direction"
	var w_name = "Scatter gun"
	super._init("res://Weapon/bullet/ScatterBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name, _cFaction)
	
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
		
