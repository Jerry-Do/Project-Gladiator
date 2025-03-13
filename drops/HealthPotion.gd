extends BaseDrop

func Effect():
	var amount = player.stats.maxHealth * (drop_resource.amount / 100)
	player.stats.SetHealth(roundi(amount))
	super()
