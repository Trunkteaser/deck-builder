extends ChanceBasedAction

@export var damage := 10

func perform_action() -> void:
	var modified_damage := enemy.modifier_handler.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	await attack_tween(modified_damage)
	Events.enemy_action_completed.emit(enemy)

func update_intent_text() -> void:
	var modified_dmg := enemy.modifier_handler.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	modified_dmg = hero.modifier_handler.get_modified_value(modified_dmg, Modifier.Type.DMG_TAKEN)
	intent.current_text = intent.base_text % modified_dmg
