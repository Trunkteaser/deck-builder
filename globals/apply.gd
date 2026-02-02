extends Node

const BLOCK_SFX: AudioStream = preload("uid://d0cq6s264xrlr")
const HEAL_SFX: AudioStream = preload("uid://bshhf0d1gfjiu")
const MANA_SFX: AudioStream = preload("uid://dudqlp1mly8lt")

# TODO Decide if giving block and taking dmg have sound effects.

var fatality_candidates := []

func damage(targets: Array[Node], amount: int, receiver_mod_type := Modifier.Type.DMG_TAKEN) -> void:
	fatality_candidates.clear()
	for target in targets:
		if not target:
			continue
		if target is Hero or target is Enemy:
			target.take_damage(amount, receiver_mod_type)

func block(targets: Array[Node], amount: int) -> void:
	for target in targets:
		if not target:
			continue
		if target is Hero or target is Enemy:
			target.stats.block += amount
			SFXPlayer.play(BLOCK_SFX)

func mood(targets: Array[Node], moood: Mood, stacks: int = 0) -> void:
	for target in targets:
		if not target:
			continue
		if target is Enemy or target is Hero:
			var mood_copy := moood.duplicate()
			mood_copy.stacks = stacks
			target.mood_handler.add_mood(mood_copy)

func draw(amount: int) -> void:
	Events.request_card_draw.emit(amount)

func discard_random(amount: int = 1) -> void:
	Events.request_random_discard.emit(amount)

func discard_specific(card_data: CardData) -> void:
	Events.request_specific_discard.emit(card_data)

func discard_type(type: CardData.Type) -> void:
	Events.request_type_discard.emit(type)

func heal(targets: Array[Node], amount: int) -> void:
	for target in targets:
		if not target:
			continue
		if target is Hero or target is Enemy:
			target.stats.heal(amount)
			SFXPlayer.play(HEAL_SFX)
 
func mana(targets: Array[Node], amount: int) -> void:
	for target in targets:
		if not target:
			continue
		if target is Hero:
			target.stats.mana += amount
			SFXPlayer.play(MANA_SFX)
