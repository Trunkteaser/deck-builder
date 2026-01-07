extends CardData

func apply_effects(targets: Array[Node]) -> void:
	var draw_effect := DrawEffect.new()
	draw_effect.apply(targets, 2)
