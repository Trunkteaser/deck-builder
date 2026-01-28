extends Panel
class_name ManaUI

@export var hero_stats: HeroStats : set = _set_hero_stats

@onready var mana_label: Label = $ManaLabel

# TODO Set mana in a different script.
#func _ready() -> void:
	#await get_tree().create_timer(1).timeout
	#hero_stats.mana = 3

func _set_hero_stats(value: HeroStats) -> void:
	hero_stats = value
	if not hero_stats.stats_changed.is_connected(_on_stats_changed):
		hero_stats.stats_changed.connect(_on_stats_changed)
	
	if not is_node_ready():
		await ready
	
	_on_stats_changed()

func _on_stats_changed() -> void:
	mana_label.text = "%s/%s" % [hero_stats.mana, hero_stats.max_mana]
