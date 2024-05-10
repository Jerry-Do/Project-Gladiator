

extends Weapon


var _cMaxAmmo = 1
var _cRateOfFire = 1
var _cReloadTime = 99999999
@onready var sprite = %Gun
func _init():
	super._init("res://Weapon/bullet/BomerangBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime)
	
func _physics_process(delta):
	super._physics_process(delta)	

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





