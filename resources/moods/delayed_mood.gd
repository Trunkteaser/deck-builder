extends Mood

@export var mood_to_delay: Mood
@export var mood_to_delay_stacks: int

# TODO Make it change the icon on initialize based on the mood_to_delay. Modulate it?

func trigger_mood(target: Node) -> void:
	Apply.mood([target], mood_to_delay, mood_to_delay_stacks)
	mood_triggered.emit(self)
	stacks = 0

func get_tooltip() -> String:
	return tooltip % [mood_to_delay_stacks, mood_to_delay.name]
