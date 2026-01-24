extends Node

const BLOCK_SFX: AudioStream = preload("uid://d0cq6s264xrlr")
const HEAL_SFX: AudioStream = preload("uid://bshhf0d1gfjiu")
# TODO Implement heal sfx here.

# TODO Decide if giving block and taking dmg have sound effects.

func damage(targets: Array[Node], amount: int) -> void: # Type of dmg?
	for target in targets:
		if not target:
			continue
		if target is Hero or target is Enemy:
			target.take_damage(amount)

func block(targets: Array[Node], amount: int) -> void:
	for target in targets:
		if not target:
			continue
		if target is Hero or target is Enemy:
			target.stats.block += amount
			SFXPlayer.play(BLOCK_SFX)

func mood(targets: Array[Node], moood: Mood, stacks: int = 0) -> void:
	var mood_copy := moood.duplicate()
	mood_copy.stacks = stacks
	for target in targets:
		if not target:
			continue
		if target is Enemy or target is Hero:
			target.mood_handler.add_mood(mood_copy)

func draw(amount: int) -> void:
	Events.request_card_draw.emit(amount)

func discard(_amount: int) -> void:
	# Implement in a post discard pile world.
	pass

func heal(targets: Array[Node], amount: int) -> void:
	for target in targets:
		if not target:
			continue
		if target is Hero or target is Enemy:
			target.stats.heal(amount)
			SFXPlayer.play(HEAL_SFX)
 
