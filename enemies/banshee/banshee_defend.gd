extends ChanceBasedAction

@export var block := 5

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var block_effect := BlockEffect.new()
	block_effect.sfx = sfx
	block_effect.apply([enemy], block)
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func(): Events.enemy_action_completed.emit(enemy))
