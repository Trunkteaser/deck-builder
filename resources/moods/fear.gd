extends Mood

const MODIFIER := -0.33

func initialize_mood(target: Node) -> void:
	var dmg_dealt_modifier: Modifier = target.modifier_handler.get_modifier(Modifier.Type.DMG_DEALT)
	var fear_modifier_value: ModifierValue = dmg_dealt_modifier.get_value("fear")
	if not fear_modifier_value:
		fear_modifier_value = ModifierValue.create_new_modifier("fear", ModifierValue.Type.PERCENT)
		fear_modifier_value.percent_value = MODIFIER
		dmg_dealt_modifier.add_new_value(fear_modifier_value)
	if not mood_changed.is_connected(_on_mood_changed):
		mood_changed.connect(_on_mood_changed.bind(dmg_dealt_modifier))

func _on_mood_changed(dmg_dealt_modifier: Modifier) -> void:
	if stacks <= 0:
		dmg_dealt_modifier.remove_value("fear")
