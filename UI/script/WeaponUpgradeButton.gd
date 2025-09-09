extends ButtonBase
var weapon : Weapon = null
var number : int = -1
func init(weapon_upgrade : WeaponUpgradeRes, _weapon : Weapon, _number: int):
	%name.text = weapon_upgrade.uname
	weapon = _weapon
	number = _number
	%description.text =weapon_upgrade.desc

func Action():
	weapon.upgrade_chosen = %name.text
	
	
