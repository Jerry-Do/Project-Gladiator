extends Weapon


var _cMaxAmmo = 1
var _cRateOfFire = 1
var _cReloadTime = 99999999
var _cFaction = "tech"
func _init():
	var description = "Throws a glave that comes back to the player, damaging everyting on the way"
	var w_name = "Glave"
	super._init("res://Weapon/bullet/GlaveBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name, _cFaction)
	
func _process(delta):
	null

func shoot():
	if(currentAmmo > 0):
		for i in 1 + double_shot:
			var BULLET = load(self.bulletName)
			var new_bullet = BULLET.instantiate()
			new_bullet.global_position = %Shootingpoint.global_position
			new_bullet.global_rotation = %Shootingpoint.global_rotation
			player.get_parent().add_child(new_bullet)
			currentAmmo -=1
			shootFlag = false
			sprite.set_visible(false)
			await get_tree().create_timer(0.05).timeout	
		double_shot = 0
