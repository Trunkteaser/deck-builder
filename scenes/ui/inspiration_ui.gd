extends HBoxContainer
class_name InspirationUI

@export var run_stats: RunStats : set = set_run_stats

@onready var label: Label = $Label

func set_run_stats(new_stats: RunStats) -> void:
	run_stats = new_stats
	
	if not run_stats.inspiration_changed.is_connected(_update_inspiration):
		run_stats.inspiration_changed.connect(_update_inspiration)
		_update_inspiration()

func _update_inspiration() -> void:
	label.text = str(run_stats.inspiration)
