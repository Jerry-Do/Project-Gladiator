extends BaseDrop

func Effect(is_player : bool):
	if is_player:
		var amount = thing.stats.ReturnMaxFuel() * (drop_resource.amount / 100.00)
		thing.stats.SetFuel(amount)
		super(true)
	else:
		thing.SetBuffTrue("speed", 4)
		super(false)
