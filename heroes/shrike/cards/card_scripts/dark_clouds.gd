extends CardData

const STATIC = preload("uid://cyjiq1cs2ewea")
const DARK_CLOUDS = preload("uid://bqdslvml6u12r")

func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	Apply.mood(targets, STATIC, 1)
	Apply.mood(targets, DARK_CLOUDS, 1)
	SFXPlayer.play(sfx)

func get_default_description() -> String:
	return description
