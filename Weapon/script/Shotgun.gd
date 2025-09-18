extends Weapon

var tracking_enemies : Array
var current_killed_amount : int = 0
var damage : float = 2
var _cMaxAmmo = 5
var _cRateOfFire = 1
var _cReloadTime = 1
@export var evolved_threshhold : int = 0
@export var pellet : int
var _cFaction = "tech"
func _init():
	var description = "Just a shotgun"
	var w_name = "Shotgun"
	super._init("res://Weapon/bullet/ShotgunBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name, _cFaction)
	
func _process(delta):
	super._process(delta)	

func shoot():
	if(currentAmmo > 0 && shootFlag):		
		for i in 1 + double_shot:
			for n in [-0.2,-0.1,0,0.2,0.1]:
				var BULLET = load(self.bulletName)
				var new_bullet = BULLET.instantiate()
				new_bullet.position = %Shootingpoint.global_position 
				new_bullet.rotation = %Shootingpoint.global_rotation + n
				new_bullet.faction = _cFaction
				new_bullet.damage = damage
				player.get_parent().add_child(new_bullet)			
				shootFlag = false	
			currentAmmo -=1
		double_shot = 0
		StartCooldownTimer()


func _on_area_2d_area_entered(area):
	if area.has_method("TakingDamageForOther"):
		tracking_enemies.append(area.get_instance_id())

func CheckIfTrackingEnemyKilled(id):
	if CheckIfEnemyIsTracked(id):
		current_killed_amount += 1
		if upgrade_chosen == "Two Shots":
			currentAmmo += 1 if currentAmmo < 2 else 0
	if (current_killed_amount == evolved_threshhold) && upgrade_chosen == "":
		CallGunUpgrade()
		
		
func CheckIfEnemyIsTracked(id):
	return tracking_enemies.find(id) != -1

func _on_area_2d_area_exited(area):
	if area.has_method("TakingDamageForOther"):
		tracking_enemies.remove_at(tracking_enemies.find((area.get_instance_id())))

func UpgradeGun():
	maxAmmo = 2
	currentAmmo = currentAmmo if currentAmmo <= 2 else 2
	damage *= 2
	
