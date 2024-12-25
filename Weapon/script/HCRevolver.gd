extends Weapon

@onready var target_timer = $TargetTimer
var target_bullet_flag = true
var _cMaxAmmo = 6
var _cRateOfFire = 0.25
var _cReloadTime = 1.25


func _init():
	var description = "Right click to shoot out a target bullet, bullets near the targetted enemy will automatically home into them"
	var w_name = "H.C Revolver"
	super._init("res://Weapon/bullet/HCBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name)
	
func _process(delta):
	super._process(delta)	

func shoot():
	if(currentAmmo > 0 && shootFlag):		
		var BULLET = load(self.bulletName)
		var new_bullet = BULLET.instantiate()
		new_bullet.position = %Shootingpoint.global_position 
		new_bullet.rotation = %Shootingpoint.global_rotation
		%Shootingpoint.add_child(new_bullet)			
		shootFlag = false		
		currentAmmo -=1
		StartCooldownTimer()

func UseGunAbility():
	if target_bullet_flag:
		var target_bullet = preload("res://Weapon/bullet/TargetBullet.tscn")
		var new_bullet = target_bullet.instantiate()
		new_bullet.position = %Shootingpoint.global_position 
		new_bullet.rotation = %Shootingpoint.global_rotation
		%Shootingpoint.add_child(new_bullet)			
		target_bullet_flag = false		
		target_timer.start(7 if game_manager.timeSlowFlag == false else 7 * 0.25)


func _on_target_timer_timeout():
	target_bullet_flag = true
