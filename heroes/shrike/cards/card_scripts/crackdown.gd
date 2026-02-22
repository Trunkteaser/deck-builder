extends CardData

@export var damage := 30
const STATIC_SFX = preload("uid://cba4h3ma7w31v")
const STATIC = preload("uid://cyjiq1cs2ewea")

func apply_effects(targets: Array[Node], modifiers: ModifierHandler) -> void:
	Apply.mood(hero, STATIC, 1)
	if not hero[0].mood_handler._get_mood("Static"):
		var modified_damage := modifiers.get_modified_value(damage, Modifier.Type.NO_MODIFIER)
		Apply.damage(targets, modified_damage)
		SFXPlayer.play(STATIC_SFX)
	elif hero[0].mood_handler._get_mood("Static").stacks > 3:
		Apply.damage(targets, 60, Modifier.Type.NO_MODIFIER)
		VFXPlayer.lightning_bolt(targets[0].global_position)
	else:
		var modified_damage := modifiers.get_modified_value(damage, Modifier.Type.NO_MODIFIER)
		Apply.damage(targets, modified_damage)
		SFXPlayer.play(STATIC_SFX)

func get_default_description() -> String:
	return description % [damage, 2*damage]

func get_updated_description(hero_modifiers: ModifierHandler, enemy_modifiers: ModifierHandler) -> String:
	var modified_damage := hero_modifiers.get_modified_value(damage, Modifier.Type.NO_MODIFIER)
	if enemy_modifiers:
		modified_damage = enemy_modifiers.get_modified_value(modified_damage, Modifier.Type.NO_MODIFIER)
	return description % [modified_damage, 2*modified_damage]
