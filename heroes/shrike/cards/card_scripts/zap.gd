extends CardData

const STATIC = preload("uid://cyjiq1cs2ewea")
@export var damage := 10

func apply_effects(targets: Array[Node], modifiers: ModifierHandler) -> void:
	var modified_damage := modifiers.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	Apply.damage(targets, modified_damage)
	Apply.mood(hero, STATIC, 1)
	SFXPlayer.play(sfx)

func get_default_description() -> String:
	return description % damage

func get_updated_description(hero_modifiers: ModifierHandler, enemy_modifiers: ModifierHandler) -> String:
	var modified_damage := hero_modifiers.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	if enemy_modifiers:
		modified_damage = enemy_modifiers.get_modified_value(modified_damage, Modifier.Type.DMG_TAKEN)
	return description % modified_damage
