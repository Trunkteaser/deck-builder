extends Mood

const MODIFIER := 0.5

func initialize_mood(target: Node) -> void:
	var dmg_taken_modifier: Modifier = target.modifier_handler.get_modifier(Modifier.Type.DMG_TAKEN)
	var fragility_modifier_value: ModifierValue = dmg_taken_modifier.get_value("fragility")
	if not fragility_modifier_value:
		fragility_modifier_value = ModifierValue.create_new_modifier("fragility", ModifierValue.Type.PERCENT)
		fragility_modifier_value.percent_value = MODIFIER
		dmg_taken_modifier.add_new_value(fragility_modifier_value)
	if not mood_changed.is_connected(_on_mood_changed):
		mood_changed.connect(_on_mood_changed.bind(dmg_taken_modifier))

func _on_mood_changed(dmg_taken_modifier: Modifier) -> void:
	if stacks <= 0:
		dmg_taken_modifier.remove_value("fragility")
