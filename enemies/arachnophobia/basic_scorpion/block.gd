extends ChanceBasedAction 

@export var block := 12

func perform_action() -> void:
	var modified_block := enemy.modifier_handler.get_modified_value(block, Modifier.Type.BLOCK_GAINED)
	Apply.block([enemy], modified_block)
	await get_tree().create_timer(0.6).timeout
	Events.enemy_action_completed.emit(enemy)
