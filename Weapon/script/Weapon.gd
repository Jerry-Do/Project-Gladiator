extends Node2D



class_name Weapon
var rateOfFire = 0
var reloadTime = 0
var maxAmmo = 0
var bulletName:String
var pickedUpFlag : bool
@export var onFloor: bool = false
@onready var playerDetector: Area2D = get_node("PlayerDetector")
var currentAmmo = 0


func _init(bullet, cRateOfFire, cMaxAmmo, cReloadTime):
	self.bulletName = bullet
	self.rateOfFire = cRateOfFire
	self.reloadTime = cReloadTime
	self.maxAmmo = cMaxAmmo
	currentAmmo = maxAmmo


var shootFlag = true
var reloadFlag = false

		
func _process(delta):
	if(currentAmmo <= 0 && !reloadFlag):
		reloadFlag = true
		$ReloadTimer.start(reloadTime)
		print("Reloading")

func _on_reload_timer_timeout():
	currentAmmo = maxAmmo
	reloadFlag = false
	print("Reloaded")

	
func _on_cooldown_timeout():
	shootFlag = true
	
func _on_player_detector_body_entered(body):
	if body != null:
		playerDetector.set_collision_mask_value(3, false)
		body.PickUpWeapon(self)
		position = Vector2.ZERO
		pickedUpFlag = true
	
