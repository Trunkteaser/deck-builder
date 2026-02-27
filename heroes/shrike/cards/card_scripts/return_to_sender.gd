extends CardData

const DELAYED_MOOD = preload("uid://cmgto428lblbb")
const THORNS = preload("uid://ppnjhh12qxjo")

func apply_effects(targets: Array[Node], _modifiers: ModifierHandler) -> void:
	#if not hero[0].stats.block:
		#return
	var amount:int = hero[0].stats.block
	var delayed_mood_sot = DELAYED_MOOD.duplicate()
	delayed_mood_sot.mood_to_delay = THORNS
	delayed_mood_sot.mood_to_delay_stacks = -amount
	
	Apply.mood(hero, THORNS, amount)
	Apply.mood(targets, delayed_mood_sot, delayed_mood_sot.mood_to_delay_stacks)
	SFXPlayer.play(sfx)

func get_default_description() -> String:
	return description
