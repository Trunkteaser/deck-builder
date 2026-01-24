extends Mood

func initialize_mood(_target: Node) -> void:
	# Connect to Events if EVENT_BASED.
	mood_changed.connect(_on_mood_changed)
	_on_mood_changed()

func _on_mood_changed() -> void:
	print("should gain +1 dmg")
