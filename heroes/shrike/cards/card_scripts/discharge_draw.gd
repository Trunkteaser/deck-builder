extends CardData

func apply_effects(_targets: Array[Node], _modifiers: ModifierHandler) -> void:
	var mood_handler: MoodHandler = hero[0].mood_handler
	var static_stacks: int
	if mood_handler._get_mood("Static"):
		static_stacks = mood_handler._get_mood("Static").stacks 
		Apply.draw(static_stacks)
		mood_handler._get_mood("Static").stacks = 0
	SFXPlayer.play(sfx)
