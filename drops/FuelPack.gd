extends BaseDrop

func Effect():
	var amount = player.stats.ReturnMaxFuel() * (drop_resource.amount / 100.00)
	player.stats.SetFuel(amount)
	super()
