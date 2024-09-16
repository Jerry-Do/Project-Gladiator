
extends Weapon


var _cMaxAmmo = 5
var _cRateOfFire = 2
var _cReloadTime = 5
var  mousePosition : Vector2
func _init():
	super._init("res://Weapon/bullet/SniperBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime)
	
	

func _process(delta):
	super._process(delta)	
	if pickedUpFlag:
		mousePosition = get_local_mouse_position()
		queue_redraw()
	
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

func _draw():
	draw_line(%Shootingpoint.position, mousePosition, Color.RED)
