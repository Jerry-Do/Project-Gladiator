
extends Weapon


var _cMaxAmmo = 8
var _cRateOfFire = 0.5
var _cReloadTime = 1.25
var _cFaction = "tech"
func _init():
	var description = "Just a handgun"
	var w_name = "Handgun"
	super._init("res://Weapon/bullet/bullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name, _cFaction)
	
func _process(delta):
	super._process(delta)	

func shoot():
	if(currentAmmo > 0 && shootFlag):
		for i in 1 + double_shot:
			var BULLET = load(self.bulletName)
			var new_bullet = BULLET.instantiate()
			new_bullet.global_position = %Shootingpoint.global_position
			new_bullet.global_rotation = %Shootingpoint.global_rotation
			new_bullet.faction = _cFaction
			player.get_parent().add_child(new_bullet)
			currentAmmo -=1
			shootFlag = false
			await get_tree().create_timer(0.05).timeout	
		double_shot = 0
		StartCooldownTimer()
			
		
