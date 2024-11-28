extends Weapon


var _cMaxAmmo = 5
var _cRateOfFire = 1
var _cReloadTime = 1
@export var pellet : int
func _init():
	var description = "Just a shotgun"
	var w_name = "Shotgun"
	super._init("res://Weapon/bullet/bullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name)
	
func _process(delta):
	super._process(delta)	

func shoot():
	if(currentAmmo > 0 && shootFlag):		
		for n in [-0.2,-0.1,0,0.2,0.1]:
			var BULLET = load(self.bulletName)
			var new_bullet = BULLET.instantiate()
			new_bullet.position = %Shootingpoint.global_position 
			new_bullet.rotation = %Shootingpoint.global_rotation + n
			%Shootingpoint.add_child(new_bullet)			
			shootFlag = false		
		currentAmmo -=1
		StartCooldownTimer()
