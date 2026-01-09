extends Node2D
class_name Hero

@export var stats: HeroStats : set = set_hero_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI

func set_hero_stats(value: HeroStats) -> void:
	stats = value
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		
	update_hero()

func update_hero() -> void:
	if not stats is HeroStats:
		return
	
	if not is_inside_tree():
		await ready
	
	sprite_2d.texture = stats.art
	update_stats()

func update_stats() -> void:
	stats_ui.update_stats(stats)

func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return
	
	stats.take_damage(damage)
	
	if stats.health <= 0:
		Events.player_died.emit()
		queue_free()
