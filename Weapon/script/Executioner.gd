
extends Weapon


var _cMaxAmmo = 4
var _cRateOfFire = 1.25
var _cReloadTime = 1.5
var can_use_ability : bool = true
var _cFaction = "R.I.S.K"
@onready var cooldown_timer : Timer = $SkillCooldown
func _init():
	var description = "Right click to go into stealh mode, killing an enemy refresh the cooldown of the stealth mode. Deals extra damage when in stealth mode"
	var w_name = "Executioner"
	super._init("res://Weapon/bullet/ExecutionerBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name, _cFaction)
	
func _process(delta):
	super._process(delta)	
		
func shoot():
	if(currentAmmo > 0 && shootFlag):
		for i in player.itemNode.num_shot:
			var BULLET = load(self.bulletName)
			var new_bullet = BULLET.instantiate()
			new_bullet.global_position = %Shootingpoint.global_position
			new_bullet.global_rotation = %Shootingpoint.global_rotation
			new_bullet.faction = _cFaction
			new_bullet.gun = self
			player.get_parent().add_child(new_bullet)
			currentAmmo -=1
			shootFlag = false
		StartCooldownTimer()
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
		$SkillCooldown.start()


func _on_skill_cooldown_timeout():
	can_use_ability = true

func StopInvisible() -> void:
	player.is_invisible = false
	player.animated_sprite.set_self_modulate(Color(1,1,1,1))
	self.sprite.set_self_modulate(Color(1,1,1,1))
	cooldown_timer.start()

func Queue_Free():
	player.is_invisible = false
	player.animated_sprite.set_self_modulate(Color(1,1,1,1))
	self.sprite.set_self_modulate(Color(1,1,1,1))
