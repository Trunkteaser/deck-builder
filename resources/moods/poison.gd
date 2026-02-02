extends Mood

func trigger_mood(target: Node) -> void:
	Apply.damage([target], stacks)
	mood_triggered.emit(self)
