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
var faction : String
var double_shot : int = 0
var upgrade_chosen : String = ""
@export var upgrades : Array = []
@export var onFloor: bool = false
@onready var playerDetector: Area2D = get_node("PlayerDetector")
@onready var sprite = $Gun
@onready var game_manager : GameManager = get_tree().get_first_node_in_group("GameManager")
var player : Player
var currentAmmo = 0
signal OutOfAmmo
signal OnEnemyKilled


func _init(bullet, cRateOfFire, cMaxAmmo, cReloadTime, cDescription, cName, cFaction):
	self.bulletName = bullet
	self.rateOfFire = cRateOfFire
	self.reloadTime = cReloadTime
	self.maxAmmo = cMaxAmmo
	self.description =  cDescription
	self.w_name = cName
	self.faction = cFaction
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

func shoot():
	if player.get_node("Item").get_node_or_null("ExtraShot") != null:
		var random_no = RandomNumberGenerator.new().randi_range(0,1)
		double_shot = random_no

func Reload():
	currentAmmo = maxAmmo
	reloadFlag = false

func StartCooldownTimer():
	var im = player.get_node("Item").get_node_or_null("IllegalModification")
	var rate_of_fire : float = self.rateOfFire 
	if im != null:
		rate_of_fire = self.rateOfFire  - self.rateOfFire  * (im.EffectAmount() / 100.0)
	$Cooldown.start(rate_of_fire  if game_manager.timeSlowFlag == false else rate_of_fire * 0.25)


func StartReloadTimer():
	var soh = player.get_node("Item").get_node_or_null("SleightOfHand")
	var reload_time : float = reloadTime
	if soh != null:
		reload_time = reloadTime - reloadTime * (soh.EffectAmount() / 100.0)
	reloadFlag = true
	$ReloadTimer.start(reload_time if game_manager.timeSlowFlag == false else reload_time * 0.25)

func CallGunUpgrade():
	game_manager.CreateWeaponUpgradeScreen(self)

func UpgradeGun():
	pass
