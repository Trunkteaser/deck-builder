extends CardData

@export var damage := 1
@export var hits := 7

func apply_effects(targets: Array[Node], modifiers: ModifierHandler) -> void:
	var modified_damage := modifiers.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	for i in hits:
		Apply.damage(targets, modified_damage)
		SFXPlayer.play(sfx)
		await wait(0.05)

func get_default_description() -> String:
	return description % damage

func get_updated_description(hero_modifiers: ModifierHandler, enemy_modifiers: ModifierHandler) -> String:
	var modified_damage := hero_modifiers.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	if enemy_modifiers:
		modified_damage = enemy_modifiers.get_modified_value(modified_damage, Modifier.Type.DMG_TAKEN)
	return description % modified_damage

func when_drawn() -> void:
	await wait(1)
	#Apply.discard_type(CardData.Type.VIOLENCE)

#func when_discarded() -> void:
	#await wait(1)
	#Apply.discard_random(2)
