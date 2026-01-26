extends CardData

func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	var damage_effect := DamageEffect.new()
	damage_effect.apply(targets, 10)
	var block_effect := BlockEffect.new()
	block_effect.apply(targets, 10)
	var draw_effect := DrawEffect.new()
	draw_effect.apply(targets, 2)
	
	# What else do I want in here?

func get_default_description() -> String:
	return description

func get_updated_description(_hero_modifiers: ModifierHandler, _enemy_modifiers: ModifierHandler) -> String:
	# % stuff
	return description
