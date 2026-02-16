extends CardData

const DAYDREAM = preload("uid://bjdhtms2mk74r")

func apply_effects(_targets: Array[Node], _modifiers: ModifierHandler) -> void:
	hero[0].stats.draw_pile.add_card(DAYDREAM)
	Apply.draw(3)
	SFXPlayer.play(sfx)

func get_default_description() -> String:
	return description
