extends BaseDrop

func Effect(is_player : bool):
	if is_player:
		if  thing.currentWeapon != null:
			var amount = roundi(thing.currentWeapon.currentAmmo * (drop_resource.amount / 100.00))
			thing.currentWeapon.currentAmmo = clamp(thing.currentWeapon.currentAmmo + amount,  thing.currentWeapon.currentAmmo + amount, thing.currentWeapon.maxAmmo)
			GameManager.instance.UpdateAmmo(thing.currentWeapon.currentAmmo)
			super(true)
	else:
		thing.SetBuffTrue("atk_speed", 4)
		super(false)
