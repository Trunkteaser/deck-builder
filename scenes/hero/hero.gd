extends Node2D
class_name Hero

const WHITE_SPRITE_MATERIAL := preload("uid://ceemqhtjalmbl")

@export var stats: HeroStats : set = set_hero_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI
@onready var mood_handler: MoodHandler = $MoodHandler
@onready var modifier_handler: ModifierHandler = $ModifierHandler

# Does it need to assign itself as the owner of MoodHandler in ready?

func set_hero_stats(value: HeroStats) -> void:
	stats = value
	stats.position = position
	
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

func take_damage(damage: int, which_modifier: Modifier.Type) -> void:
	if stats.health <= 0:
		return
	
	sprite_2d.material = WHITE_SPRITE_MATERIAL
	var modified_damage := modifier_handler.get_modified_value(damage, which_modifier)
	
	var tween := create_tween()
	tween.tween_callback(Shaker.shake.bind(self, 32, 0.15))
	tween.tween_callback(stats.take_damage.bind(modified_damage))
	tween.tween_interval(0.17)
	
	tween.finished.connect(
		func():
			sprite_2d.material = null
			if stats.health <= 0:
				Events.player_died.emit()
				queue_free())
