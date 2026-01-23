extends GridContainer
class_name MoodHandler

signal moods_triggered(trigger_type: Mood.TriggerType)

const MOOD_APPLY_INTERVAL := 0.25
const MOOD_UI = preload("uid://c0xju7lemx4bx")

@export var mood_owner: Node2D

func trigger_moods_by_type(trigger_type: Mood.TriggerType) -> void:
	if trigger_type == Mood.TriggerType.EVENT_BASED:
		return # They handle it on their own with Event bus.
	var mood_queue: Array[Mood] = _get_all_moods().filter(
		func(mood: Mood):
			return mood.trigger_type == trigger_type)
	if mood_queue.is_empty():
		moods_triggered.emit(trigger_type)
		return
	var tween := create_tween()
	for mood: Mood in mood_queue:
		tween.tween_callback(mood.trigger_mood.bind(mood_owner))
		tween.tween_interval(MOOD_APPLY_INTERVAL)
	tween.finished.connect(func(): moods_triggered.emit(trigger_type))

func add_mood(mood: Mood) -> void:
	var stackable := mood.stack_type != Mood.StackType.NONE
	# Add it if it's new.
	if not _has_mood(mood.name):
		var new_mood_ui: MoodUI = MOOD_UI.instantiate()
		add_child(new_mood_ui)
		new_mood_ui.mood = mood
		new_mood_ui.mood.mood_triggered.connect(_on_mood_triggered)
		new_mood_ui.mood.initialize_mood(mood_owner)
	# If we already have it, and it doesn't stack, return.
	elif not stackable:
		return
	# If we already have it, and it can stack...
	elif stackable:
		_get_mood(mood.name).stacks += mood.stacks # Add the stacks to the former instance.

func _has_mood(mood_name: String) -> bool:
	for mood_ui: MoodUI in get_children():
		if mood_ui.mood.name == mood_name:
			return true
	return false

func _get_mood(mood_name: String) -> Mood:
	for mood_ui: MoodUI in get_children():
		if mood_ui.mood.name == mood_name:
			return mood_ui.mood
	return null

func _get_all_moods() -> Array[Mood]:
	var moods: Array[Mood] = []
	for mood_ui: MoodUI in get_children():
		moods.append(mood_ui.mood)
	return moods

func _on_mood_triggered(mood: Mood) -> void:
	if mood.stack_type == Mood.StackType.DURATION: # Can expire.
		mood.stacks -= 1
