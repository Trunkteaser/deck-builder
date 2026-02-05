extends Mood

@export var sfx: AudioStream

const MODIFIER := -0.0999

func initialize_mood(target: Node) -> void:
	Events.card_played.connect(_on_card_played.bind(target))
	mood_changed.connect(_on_mood_changed.bind(target))
	_on_mood_changed(target)

func _on_mood_changed(target: Node) -> void:
	var dmg_dealt_modifier: Modifier = target.modifier_handler.get_modifier(Modifier.Type.DMG_DEALT)
	var web_modifier_value: ModifierValue = dmg_dealt_modifier.get_value("web")
	if not web_modifier_value:
		web_modifier_value = ModifierValue.create_new_modifier("web", ModifierValue.Type.PERCENT)
	web_modifier_value.percent_value = MODIFIER*stacks
	dmg_dealt_modifier.add_new_value(web_modifier_value)
	
	SFXPlayer.play(sfx)
	
	if stacks <= 0:
		dmg_dealt_modifier.remove_value("web")

func _on_card_played(_card_data: CardData, target: Node) -> void:
	await target.get_tree().process_frame
	stacks -= 1
	

func get_tooltip() -> String:
	return tooltip % (str(int(0.1*stacks*100)) + "%")
