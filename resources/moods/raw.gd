extends Mood

func initialize_mood(target: Node) -> void:
	mood_changed.connect(_on_mood_changed.bind(target))
	_on_mood_changed(target)

func _on_mood_changed(target: Node) -> void:
	var dmg_taken_modifier: Modifier = target.modifier_handler.get_modifier(Modifier.Type.DMG_TAKEN)
	var raw_modifier_value: ModifierValue = dmg_taken_modifier.get_value("raw")
	if not raw_modifier_value:
		raw_modifier_value = ModifierValue.create_new_modifier("raw", ModifierValue.Type.FLAT)
	raw_modifier_value.flat_value = stacks
	dmg_taken_modifier.add_new_value(raw_modifier_value)

func get_tooltip() -> String:
	return tooltip % stacks
