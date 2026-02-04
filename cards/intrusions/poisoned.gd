extends CardData

@export var damage := 3

func apply_effects(_targets: Array[Node], _modifiers: ModifierHandler) -> void:
	SFXPlayer.play(sfx)

func when_retained() -> void:
	Apply.damage(hero, 3, Modifier.Type.NO_MODIFIER)
	SFXPlayer.play(sfx)
