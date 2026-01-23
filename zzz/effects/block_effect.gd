extends Effect
class_name BlockEffect

const BLOCK_SFX: AudioStream = preload("uid://d0cq6s264xrlr")

func apply(targets: Array[Node], amount: int) -> void:
	for target in targets:
		if not target: # If null.
			continue
		if target is Hero or target is Enemy:
			target.stats.block += amount
			if sfx: SFXPlayer.play(sfx)
			else: SFXPlayer.play(BLOCK_SFX)
