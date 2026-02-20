extends Mood

func initialize_mood(_target: Node) -> void:
	# Connect to Events if EVENT_BASED.
	pass

func trigger_mood(_target: Node) -> void:
	# Stacks will automatically be lost if DURATION based.
	mood_triggered.emit(self)
