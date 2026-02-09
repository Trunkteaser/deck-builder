extends ChanceBasedAction

@export var damage = 4

func perform_action() -> void:
	var modified_damage := enemy.modifier_handler.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	for i in 2:
		await wait(0.5)
		if not target:
			break
		attack_tween(modified_damage)
		#Apply.damage([target], damage)
		#SFXPlayer.play(sfx)
	await wait (0.5)
	Events.enemy_action_completed.emit(enemy)

func update_intent_text() -> void:
	#var hero: Hero = target
	#if not hero:
		#return
	#var modified_dmg: int = hero.modifier_handler.get_modified_value(damage, Modifier.Type.DMG_TAKEN)
	#intent.current_text = intent.base_text % modified_dmg
	var modified_dmg := enemy.modifier_handler.get_modified_value(damage, Modifier.Type.DMG_DEALT)
	modified_dmg = hero.modifier_handler.get_modified_value(modified_dmg, Modifier.Type.DMG_TAKEN)
	intent.current_text = intent.base_text % modified_dmg
