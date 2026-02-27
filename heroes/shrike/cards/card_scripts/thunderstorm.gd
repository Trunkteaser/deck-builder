extends CardData

@export var damage := 10
const STATIC_SFX = preload("uid://cba4h3ma7w31v")
const STATIC = preload("uid://cyjiq1cs2ewea")

func apply_effects(targets: Array[Node], modifiers: ModifierHandler) -> void:
	if not hero[0].mood_handler._get_mood("Static"):
		return
	var hits:int = hero[0].mood_handler._get_mood("Static").stacks
	var modified_damage := modifiers.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	for i in hits:
		Apply.damage(targets, modified_damage)
		SFXPlayer.play(STATIC_SFX)
		await wait(0.05)
	if hero[0].is_inside_tree():
		hero[0].mood_handler._get_mood("Static").stacks = 0

func get_default_description() -> String:
	return description % ["Static stacks", damage]

func get_updated_description(hero_modifiers: ModifierHandler, enemy_modifiers: ModifierHandler) -> String:
	var modified_damage := hero_modifiers.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	var hits:int = 0
	if not hero[0].mood_handler._get_mood("Static"):
		pass
	else:
		hits = hero[0].mood_handler._get_mood("Static").stacks
	if enemy_modifiers:
		modified_damage = enemy_modifiers.get_modified_value(modified_damage, Modifier.Type.DMG_TAKEN)
	return description % [hits, modified_damage]
