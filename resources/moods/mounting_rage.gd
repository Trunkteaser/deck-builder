extends Mood

const ANGER = preload("uid://bl7yry7rm0qru")
@export var anger_per_turn := 2

func trigger_mood(target: Node) -> void:
	Apply.mood([target], ANGER, anger_per_turn)
	mood_triggered.emit(self)
