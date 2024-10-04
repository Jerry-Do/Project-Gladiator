
extends Weapon


var _cMaxAmmo = 4
var _cRateOfFire = 1.25
var _cReloadTime = 2
var can_use_ability : bool = true
@onready var cooldown_timer : Timer = $SkillCooldown
func _init():
	super._init("res://Weapon/bullet/ExecutionerBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime)
	
func _process(delta):
	super._process(delta)	

func shoot():
	if(currentAmmo > 0 && shootFlag):
		var BULLET = load(self.bulletName)
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %Shootingpoint.global_position
		new_bullet.global_rotation = %Shootingpoint.global_rotation
		%Shootingpoint.add_child(new_bullet)
		currentAmmo -=1
		shootFlag = false
		$Cooldown.start(self.rateOfFire  if game_manager.timeSlowFlag == false else self.rateOfFire * 0.25)
		StopInvisible()
		
func UseGunAbility():
	if player != null && can_use_ability:
		can_use_ability = false
		player.is_invisible = true
		player.animated_sprite.set_self_modulate(Color(1,1,1,0.25))
		self.sprite.set_self_modulate(Color(1,1,1,0.25))
		$Duration.start()

func _on_duration_timeout():
	if player != null:
		StopInvisible()


func _on_skill_cooldown_timeout():
	can_use_ability = true

func StopInvisible() -> void:
	player.is_invisible = false
	player.animated_sprite.set_self_modulate(Color(1,1,1,1))
	self.sprite.set_self_modulate(Color(1,1,1,1))
	cooldown_timer.start()
