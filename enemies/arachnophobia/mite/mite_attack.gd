extends ChanceBasedAction

@export var damage = 9999999
const MITE_CARD = preload("uid://eynjiijuxrvr")

func perform_action() -> void:
	hero.stats.discard_pile.add_card(MITE_CARD)
	Events.enemy_action_completed.emit(enemy)
	Apply.damage([enemy], 9999999, Modifier.Type.NO_MODIFIER)

func update_intent_text() -> void:
	#var modified_dmg := enemy.modifier_handler.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	#modified_dmg = hero.modifier_handler.get_modified_value(modified_dmg, Modifier.Type.DMG_TAKEN)
	intent.current_text = intent.base_text
