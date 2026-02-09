extends CardData

@export var damage := 10

func apply_effects(_targets: Array[Node], _modifiers: ModifierHandler) -> void:
	SFXPlayer.play(sfx)

func when_drawn() -> void:
	Apply.damage(hero, 10, Modifier.Type.NO_MODIFIER)
	SFXPlayer.play(sfx)
