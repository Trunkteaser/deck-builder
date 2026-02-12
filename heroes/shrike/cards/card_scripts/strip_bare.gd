extends CardData

const STRIP_BARE = preload("uid://cd3ywftifg6l2")

func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	Apply.mood(targets, STRIP_BARE)
	SFXPlayer.play(sfx)
