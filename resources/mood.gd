@icon("res://assets/sprites/mood.png")
extends Resource
class_name Mood

signal mood_triggered(mood: Mood)
signal mood_changed

# TriggerType describes whether you want anything to happen to the mood at sot or eot.
enum TriggerType {START_OF_TURN, END_OF_TURN, EVENT_BASED}
enum StackType {NONE, INTENSITY, DURATION}

@export var name: String
@export var trigger_type: TriggerType
@export var stack_type: StackType
#@export var can_expire: bool # Wouldn't every duration based one expire?
@export var stacks: int : set = set_stacks

@export var icon: Texture2D
@export_multiline var tooltip: String

func initialize_mood(_target: Node) -> void:
	# Can connect to event bus for event based here.
	pass

func trigger_mood(_target: Node) -> void:
	mood_triggered.emit(self)

func get_tooltip() -> String:
	return tooltip

func set_stacks(new_stacks: int) -> void:
	stacks = new_stacks
	mood_changed.emit()
