extends Mood

const MODIFIER := 1.0

func initialize_mood(target: Node) -> void:
	var dmg_taken_modifier: Modifier = target.modifier_handler.get_modifier(Modifier.Type.DMG_TAKEN)
	var dmg_dealt_modifier: Modifier = target.modifier_handler.get_modifier(Modifier.Type.DMG_DEALT)
	var love_given_modifier_value: ModifierValue = dmg_taken_modifier.get_value("i_give_love_freely")
	var love_received_modifier_value: ModifierValue = dmg_dealt_modifier.get_value("i_give_love_freely")
	if not love_received_modifier_value:
		love_received_modifier_value = ModifierValue.create_new_modifier("i_give_love_freely", ModifierValue.Type.PERCENT)
		love_received_modifier_value.percent_value = MODIFIER
		dmg_taken_modifier.add_new_value(love_received_modifier_value)
	if not love_given_modifier_value:
		love_given_modifier_value = ModifierValue.create_new_modifier("i_give_love_freely", ModifierValue.Type.PERCENT)
		love_given_modifier_value.percent_value = MODIFIER
		dmg_dealt_modifier.add_new_value(love_given_modifier_value)
	if not mood_changed.is_connected(_on_mood_changed):
		mood_changed.connect(_on_mood_changed.bind(dmg_dealt_modifier))
	if not mood_changed.is_connected(_on_mood_changed):
		mood_changed.connect(_on_mood_changed.bind(dmg_taken_modifier))

func _on_mood_changed(dmg_taken_modifier: Modifier) -> void:
	if stacks <= 0:
		dmg_taken_modifier.remove_value("i_give_love_freely")
#func _on_mood_changed(dmg_dealt_modifier: Modifier) -> void:
#	if stacks <= 0:
#		dmg_dealt_modifier.remove_value("fear")

	
