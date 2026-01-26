extends Control
class_name MoodUI

@export var mood: Mood : set = set_mood

@onready var icon: TextureRect = $Icon
@onready var stacks: Label = $Stacks

func set_mood(new_mood: Mood) -> void:
	if not is_node_ready():
		await ready
	mood = new_mood
	tooltip_text = mood.tooltip
	icon.texture = mood.icon
	stacks.visible = mood.stack_type != Mood.StackType.NONE
	custom_minimum_size = icon.size
	if stacks.visible:
		custom_minimum_size = stacks.size + stacks.position
	if not mood.mood_changed.is_connected(_on_mood_changed):
		mood.mood_changed.connect(_on_mood_changed)
	_on_mood_changed()

func _on_mood_changed() -> void:
	if not mood:
		return
	if mood.stack_type == Mood.StackType.DURATION and mood.stacks <= 0:
		queue_free()
	elif mood.stack_type == Mood.StackType.INTENSITY and mood.stacks == 0:
		queue_free()
	stacks.text = str(mood.stacks)
