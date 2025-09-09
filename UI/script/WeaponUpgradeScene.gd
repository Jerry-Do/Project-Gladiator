
extends Control
#to upgrade weapon, must satisfy an unique condition based on which weapon

var weapon : Weapon = preload("res://Weapon/SpeedGun.tscn").instantiate()

func _ready():
	for i in 2:
		var upgrade = preload("res://UI/WeaponUpgradeButton.tscn")
		var real = upgrade.instantiate()
		real.init(weapon.upgrades[i], weapon, i)
		real.global_position = %ButtonsContainer.get_child(i).global_position
		%ButtonsContainer.add_child(real)
	
	
