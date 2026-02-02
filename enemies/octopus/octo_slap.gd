extends ChanceBasedAction

@export var damage := 2

func perform_action() -> void:
	for i in 8:
		await wait(0.1)
		if not target:
			break
		Apply.damage([target], damage)
		SFXPlayer.play(sfx)

	Events.enemy_action_completed.emit(enemy)

func update_intent_text() -> void:
	var hero: Hero = target
	if not hero:
		return
	var modified_dmg := hero.modifier_handler.get_modified_value(damage, Modifier.Type.DMG_TAKEN)
	intent.current_text = intent.base_text % modified_dmg
