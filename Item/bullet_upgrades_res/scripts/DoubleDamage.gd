extends BaseBulletUpgrade


func UpgradeBullet(bullet : BaseBullet):
	print("Double Damage")
	bullet.damage *= (amount / 100.0)
