extends Mood

const MODIFIER := 0.5

func trigger_mood(target: Node) -> void:
	Apply.damage([target], 3)
	mood_triggered.emit(self)
