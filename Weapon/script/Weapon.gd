extends Node2D
class_name Weapon
var rateOfFire = 0
var reloadTime = 0
var shootFlag = true
var reloadFlag = false
var maxAmmo = 0
var bulletName:String
var pickedUpFlag : bool
var description : String
var w_name : String
@export var onFloor: bool = false
@onready var playerDetector: Area2D = get_node("PlayerDetector")
@onready var sprite = $Gun
@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
var player : Player
var currentAmmo = 0


func _init(bullet, cRateOfFire, cMaxAmmo, cReloadTime, cDescription, cName):
	self.bulletName = bullet
	self.rateOfFire = cRateOfFire
	self.reloadTime = cReloadTime
	self.maxAmmo = cMaxAmmo
	self.description =  cDescription
	self.w_name = cName
	currentAmmo = maxAmmo



		
func _process(_delta):
	if(currentAmmo <= 0 && !reloadFlag):
		StartReloadTimer()



func _on_reload_timer_timeout():
	Reload()


	
func _on_cooldown_timeout():
	shootFlag = true
	
func _on_player_detector_body_entered(body):
	if body != null:
		player = body
		playerDetector.set_collision_mask_value(3, false)
		body.PickUpWeapon(self)
		position = Vector2.ZERO
		pickedUpFlag = true
	
func ReturnDescription() -> String:
	return description
	
func ReturnName() -> String:
	return w_name



func Reload():
	currentAmmo = maxAmmo
	reloadFlag = false

func StartCooldownTimer():
	$Cooldown.start(self.rateOfFire  if game_manager.timeSlowFlag == false else self.rateOfFire * 0.25)


func StartReloadTimer():
	reloadFlag = true
	$ReloadTimer.start(reloadTime if game_manager.timeSlowFlag == false else reloadTime * 0.25)
