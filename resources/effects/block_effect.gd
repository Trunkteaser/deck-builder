extends Effect
class_name BlockEffect

func apply(targets: Array[Node], amount: int) -> void:
	for target in targets:
		if not target: # If null.
			continue
		if target is Hero or target is Enemy:
			target.stats.block += amount
