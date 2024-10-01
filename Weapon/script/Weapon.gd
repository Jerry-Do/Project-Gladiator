extends Node2D



class_name Weapon
var rateOfFire = 0
var reloadTime = 0
var shootFlag = true
var reloadFlag = false
var maxAmmo = 0
var bulletName:String
var pickedUpFlag : bool
@export var onFloor: bool = false
@onready var playerDetector: Area2D = get_node("PlayerDetector")
@onready var sprite = $Gun

@onready var game_manager = get_tree().get_first_node_in_group("GameManager")
var currentAmmo = 0


func _init(bullet, cRateOfFire, cMaxAmmo, cReloadTime):
	self.bulletName = bullet
	self.rateOfFire = cRateOfFire
	self.reloadTime = cReloadTime
	self.maxAmmo = cMaxAmmo
	currentAmmo = maxAmmo



		
func _process(_delta):
	if(currentAmmo <= 0 && !reloadFlag):
		reloadFlag = true
		$ReloadTimer.start(reloadTime if game_manager.timeSlowFlag == false else reloadTime * 0.25)
		print("Reloading")
	if get_parent().name == "Weapon":
		var mouse_pos = get_viewport().get_mouse_position()
		var direction = get_global_mouse_position() - global_position
		if direction.sign().x < 0:
			sprite.set_flip_v(true)
		else:
			sprite.set_flip_v(false)

func _on_reload_timer_timeout():
	currentAmmo = maxAmmo
	reloadFlag = false
	print("Reloaded")

	
func _on_cooldown_timeout():
	shootFlag = true
	
func _on_player_detector_body_entered(body):
	if body != null:
		print("Picked up")
		playerDetector.set_collision_mask_value(3, false)
		body.PickUpWeapon(self)
		position = Vector2.ZERO
		pickedUpFlag = true
	
