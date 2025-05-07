extends GunUpgrade
class_name SleightOfHand

func UpgradeGun(gun : Weapon):
	gun.rateOfFire *= (1.0 - amount)
