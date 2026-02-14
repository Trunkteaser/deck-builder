extends Node
class_name Modifier

enum Type {
	DMG_DEALT,
	DMG_TAKEN,
	BLOCK_GAINED,
	CARD_COST,
	SHOP_COST,
	NO_MODIFIER
}

@export var type: Type

func get_value(source: String) -> ModifierValue:
	for value: ModifierValue in get_children():
		if value.source == source:
			return value
	return null

func add_new_value(value: ModifierValue) -> void:
	var modifier_value := get_value(value.source)
	if not modifier_value: # If we don't already have it...
		add_child(value)
	else:
		modifier_value.flat_value = value.flat_value
		modifier_value.percent_value = value.percent_value
	Events.update_card_descriptions.emit()

func remove_value(source: String) -> void:
	for value: ModifierValue in get_children():
		if value.source == source:
			value.queue_free()
	Events.update_card_descriptions.emit()

func clear_values() -> void:
	for value: ModifierValue in get_children():
		value.queue_free()
	Events.update_card_descriptions.emit()

func get_modified_value(base: int) -> int:
	var flat_result: int = base
	var percent_result: float = 1.0
	# TODO Add "more" multipliers?
	for value: ModifierValue in get_children():
		if value.type == ModifierValue.Type.FLAT:
			flat_result += value.flat_value
		elif value.type == ModifierValue.Type.PERCENT:
			percent_result += value.percent_value
	return clampi(floori(flat_result * percent_result), 0, 9999)
