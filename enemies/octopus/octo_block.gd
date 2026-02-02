extends ChanceBasedAction

@export var block := 2

func perform_action() -> void:
	for i in 8:
		await wait(0.1)
		Apply.block([enemy], block)
	Events.enemy_action_completed.emit(enemy)
