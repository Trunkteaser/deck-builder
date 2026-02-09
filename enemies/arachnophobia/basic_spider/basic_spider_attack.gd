extends ChanceBasedAction

@export var damage = 4

func perform_action() -> void:
	for i in 2:
		await wait(0.5)
		if not target:
			break
		Apply.damage([target], damage)
		SFXPlayer.play(sfx)
	await wait (0.5)
	Events.enemy_action_completed.emit(enemy)

func update_intent_text() -> void:
	#var hero: Hero = target
	if not hero:
		return
	var modified_dmg: int = hero.modifier_handler.get_modified_value(damage, Modifier.Type.DMG_TAKEN)
	intent.current_text = intent.base_text % modified_dmg
