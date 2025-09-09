extends BaseBulletUpgrade

func UpgradeBullet(bullet : BaseBullet):
	var tmp : Array
	for i in bullet.status_dictionary:
		tmp.append(i)
	var random_no = RandomNumberGenerator.new().randi_range(0, bullet.status_dictionary.size() - 1)
	print(tmp[random_no])
	bullet.status_dictionary[tmp[random_no]] = true
