extends CardData

const THORNS = preload("uid://ppnjhh12qxjo")

func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	Apply.block(targets, 10)
	Apply.mood(targets, THORNS, 3)
	SFXPlayer.play(sfx)

func get_default_description() -> String:
	return description
