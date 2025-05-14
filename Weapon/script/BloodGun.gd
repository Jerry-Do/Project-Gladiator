
extends Weapon


var _cMaxAmmo = 10
var _cRateOfFire = 0.1
var _cReloadTime = 1
var _cFaction = "biochemical"
var restore_health_mode = false

func _init():
	var description = "Consumes health to deal increase damage, right click to switch mode to restore health instead"
	var w_name = "Bloodgun"
	super._init("res://Weapon/bullet/BloodBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name, _cFaction)
	
func _process(delta):
	super._process(delta)	

func shoot():
	super()
	for i in 1 + double_shot:
		var BULLET = null
		if restore_health_mode == false:
			BULLET = preload("res://Weapon/bullet/BloodBullet.tscn")
			player.stats.SetHealth(-1)
		else:
			BULLET = preload("res://Weapon/bullet/RestoreBloodBullet.tscn")
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %Shootingpoint.global_position
		new_bullet.global_rotation = %Shootingpoint.global_rotation
		new_bullet.faction = _cFaction
		player.get_parent().add_child(new_bullet)	
		shootFlag = false
		await get_tree().create_timer(0.05).timeout	
	double_shot = 0
	StartCooldownTimer()
		
func UseGunAbility():
	restore_health_mode = true
