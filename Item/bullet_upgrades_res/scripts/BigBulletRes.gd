extends BaseBulletUpgrade


func UpgradeBullet(bullet : BaseBullet):
	print("Big Bullet")
	var x = bullet.scale.x * (1.0 + (amount / 100.0))
	var y = bullet.scale.y * (1.0 + (amount / 100.0))
	bullet.scale = Vector2(x,y)
