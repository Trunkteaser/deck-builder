extends CardData

const STUNNED = preload("uid://bbdj8vx4ayevi")
@export var damage := 28

func apply_effects(targets: Array[Node], modifiers: ModifierHandler) -> void:
	var modified_damage := modifiers.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	Apply.damage(targets, modified_damage)
	hero[0].stats.discard_pile.add_card(STUNNED)
	hero[0].stats.discard_pile.add_card(STUNNED)
	SFXPlayer.play(sfx)

func get_default_description() -> String:
	return description % damage

func get_updated_description(hero_modifiers: ModifierHandler, enemy_modifiers: ModifierHandler) -> String:
	var modified_damage := hero_modifiers.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	if enemy_modifiers:
		modified_damage = enemy_modifiers.get_modified_value(modified_damage, Modifier.Type.DMG_TAKEN)
	return description % modified_damage
