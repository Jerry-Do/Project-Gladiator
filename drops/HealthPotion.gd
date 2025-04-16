extends BaseDrop

func Effect(is_player : bool):
	if is_player:
		var amount = thing.stats.maxHealth * (drop_resource.amount / 100.00)
		thing.stats.SetHealth(roundi(amount))
		super(true)
	else:
		var amount = thing.sHealth * (drop_resource.amount / 100.00)
		thing.stats_dic["health"] = clampi(thing.stats_dic["health"] + amount, thing.stats_dic["health"] + amount,thing.sHealth )
		super(false)
