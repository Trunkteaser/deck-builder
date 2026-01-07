extends CardData

func apply_effects(targets: Array[Node]) -> void:
	var damage_effect := DamageEffect.new()
	damage_effect.apply(targets, 10)
	var block_effect := BlockEffect.new()
	block_effect.apply(targets, 10)
	var draw_effect := DrawEffect.new()
	draw_effect.apply(targets, 2)
	
	# What else do I want in here?
