extends CardData

@export var block := 25

func apply_effects(targets: Array[Node], modifiers: ModifierHandler) -> void:
	var modified_block := modifiers.get_modified_value(block, Modifier.Type.BLOCK_GAINED)
	Apply.block(targets, modified_block)
	#SFXPlayer.play(sfx)

func get_default_description() -> String:
	return description % block

func get_updated_description(hero_modifiers: ModifierHandler, _enemy_modifiers: ModifierHandler) -> String:
	var modified_block := hero_modifiers.get_modified_value(block, Modifier.Type.BLOCK_GAINED)
	return description % modified_block
