
extends Weapon


var _cMaxAmmo = 15
var _cRateOfFire = 0.75
var _cReloadTime = 1.25
var charge : float = 0
var max_charge : float = 5.0
@onready var speed_bar = $SpeedBar
func _init():
	var description = "Moving charges up the gun. When fully charged, consume all the charges to deal extra damage"
	var w_name = "Speed gun"
	super._init("res://Weapon/bullet/SpeedBullet.tscn", _cRateOfFire, _cMaxAmmo, _cReloadTime, description, w_name)
	

func _ready():
	speed_bar.init_speed(0)
	
func _process(delta):
	super._process(delta)	
	if pickedUpFlag:
		speed_bar.show()
	if get_parent().get_parent() == get_tree().get_first_node_in_group("player"):
		if get_parent().get_parent().movement_component.get_movement_direction() != Vector2.ZERO && charge < max_charge:
			charge += delta
			speed_bar._set_speed(charge)
			
func shoot():
	if(currentAmmo > 0 && shootFlag):
		for n in 3:
			var BULLET = load(self.bulletName)
			var new_bullet = BULLET.instantiate()
			new_bullet.global_position = %Shootingpoint.global_position
			new_bullet.global_rotation = %Shootingpoint.global_rotation
			%Shootingpoint.add_child(new_bullet)
			if round(charge) == round(max_charge):
				new_bullet.fully_charged = true
			currentAmmo -=1
			shootFlag = false
			await get_tree().create_timer(0.05).timeout
		if round(charge) == round(max_charge):
			charge = 0
			speed_bar._set_speed(charge)
		StartCooldownTimer()
		
