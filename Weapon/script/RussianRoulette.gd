
extends Weapon


var _cMaxAmmo = 6
var _cRateOfFire = 0.2
var _cReloadTime = 1.5
var current_shot_count = 0
var self_damage = 5
var _cFaction = "R.I.S.K"
func _init():
	var description = "Each shot increases the damage of the after. There is a chance that the current bullet will explode and damage the player " + \
	"The explosion will force the gun to be reloaded"
	var w_name = "Russian Roulette"
	super._init("res://Weapon/bullet/RussianRouletteBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name, _cFaction)
	
func _process(delta):
	super._process(delta)	

func shoot():
	if(currentAmmo > 0 && shootFlag):
		var random_no = randi_range(1,10)
		current_shot_count += 1
		if random_no == 10 || current_shot_count == 6:
			get_tree().get_first_node_in_group("player").stats.SetHealth(-self_damage)
			currentAmmo = 0
			StartCooldownTimer()
		else:
			var BULLET = load(self.bulletName)
			var new_bullet = BULLET.instantiate()
			new_bullet.global_position = %Shootingpoint.global_position
			new_bullet.global_rotation = %Shootingpoint.global_rotation
			new_bullet.faction = _cFaction
			new_bullet.damage += current_shot_count * 2
			player.get_parent().add_child(new_bullet)
			currentAmmo -=1
			shootFlag = false
			StartCooldownTimer()
			

func Reload():
	super()
	current_shot_count = 0
