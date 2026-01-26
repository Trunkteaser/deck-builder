extends Mood

func initialize_mood(target: Node) -> void:
	mood_changed.connect(_on_mood_changed.bind(target))
	_on_mood_changed(target)

func _on_mood_changed(target: Node) -> void:
	# Can check existance of handler and dmg_dealt modifier via assert.
	var dmg_dealt_modifier: Modifier = target.modifier_handler.get_modifier(Modifier.Type.DMG_DEALT)
	var anger_modified_value := dmg_dealt_modifier.get_value("anger")
	if not anger_modified_value:
		anger_modified_value = ModifierValue.create_new_modifier("anger", ModifierValue.Type.FLAT)
	anger_modified_value.flat_value = stacks
	dmg_dealt_modifier.add_new_value(anger_modified_value)

func get_tooltip() -> String:
	return tooltip % stacks
