extends Weapon


var _cMaxAmmo = 5
var _cRateOfFire = 1
var _cReloadTime = 1
@export var pellet : int
func _init():
	super._init("res://Weapon/bullet/bullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime)
	
func _physics_process(delta):
	super._physics_process(delta)	

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
		$Cooldown.start(self.rateOfFire)






