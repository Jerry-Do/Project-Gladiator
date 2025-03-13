extends BaseDrop

func Effect():
	if  player.currentWeapon != null:
		var amount = roundi(player.currentWeapon.currentAmmo * (drop_resource.amount / 100.00))
		player.currentWeapon.currentAmmo = clamp(player.currentWeapon.currentAmmo + amount,  player.currentWeapon.currentAmmo + amount, player.currentWeapon.maxAmmo)
		GameManager.instance.UpdateAmmo(player.currentWeapon.currentAmmo)
		super()
		
