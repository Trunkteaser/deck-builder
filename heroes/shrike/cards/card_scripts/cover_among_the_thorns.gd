extends CardData

const THORNS = preload("uid://ppnjhh12qxjo")

func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	Apply.mood(targets, THORNS, 3)
	var amount:int = hero[0].mood_handler._get_mood("Thorns").stacks
	Apply.block(targets, amount)
	SFXPlayer.play(sfx)

func get_default_description() -> String:
	return description
