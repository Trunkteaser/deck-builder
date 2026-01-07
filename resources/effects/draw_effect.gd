extends Effect
class_name DrawEffect

func apply(targets: Array[Node], amount: int = 1) -> void:
	for target in targets:
		if not target:
			continue
		if target is Hero or target is Enemy:
			for i in amount:
				Events.request_card_draw.emit()
