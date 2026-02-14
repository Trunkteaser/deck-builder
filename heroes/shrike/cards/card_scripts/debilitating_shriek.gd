extends CardData

const DELAYED_MOOD = preload("uid://dfrpol1cbarq2")
const ANGER = preload("uid://bl7yry7rm0qru")

func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	var delayed_mood = DELAYED_MOOD.duplicate()
	delayed_mood.mood_to_delay = ANGER
	delayed_mood.mood_to_delay_stacks = 4
	
	Apply.mood(targets, ANGER, -4)
	Apply.mood(targets, delayed_mood, delayed_mood.mood_to_delay_stacks)
