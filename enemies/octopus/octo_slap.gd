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
