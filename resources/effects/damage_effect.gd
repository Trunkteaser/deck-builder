extends Effect
class_name DamageEffect

func apply(targets: Array[Node], amount: int) -> void:
	for target in targets:
		if not target: # If null.
			continue
		if target is Hero or target is Enemy:
			target.take_damage(amount)
