extends CardData

const AGITATION = preload("uid://dyw0lf0gro5sd")

func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	Apply.mood(targets, AGITATION, 1)
	SFXPlayer.play(sfx)
