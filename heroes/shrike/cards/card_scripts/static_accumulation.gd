extends CardData

const STATIC = preload("uid://cyjiq1cs2ewea")

func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	Apply.mood(targets, STATIC, 3)
	SFXPlayer.play(sfx)

func get_default_description() -> String:
	return description
