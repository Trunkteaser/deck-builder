extends Node

const BLOCK_SFX: AudioStream = preload("uid://d0cq6s264xrlr")

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

func draw(amount: int) -> void:
	Events.request_card_draw.emit(amount)

func discard(_amount: int) -> void:
	# Implement in a post discard pile world.
	pass
 
