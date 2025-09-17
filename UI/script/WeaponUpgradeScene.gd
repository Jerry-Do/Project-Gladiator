
extends Control
#Check what happens if the upgrade weapon and item buy screen appears at the same time
#
var weapon : Weapon = null

func _ready():
	if weapon != null:
		for i in 2:
			var upgrade = preload("res://UI/WeaponUpgradeButton.tscn")
			var real = upgrade.instantiate()
			real.get_child(0).init(weapon.upgrades[i], weapon, i)
			real.global_position = %ButtonsContainer.get_child(i).global_position
			%ButtonsContainer.add_child(real)
	
	
