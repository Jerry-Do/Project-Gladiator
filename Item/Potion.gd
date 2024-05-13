extends Item

func Use():
	var stats = PlayerStats
	stats.stats.Health += 1
