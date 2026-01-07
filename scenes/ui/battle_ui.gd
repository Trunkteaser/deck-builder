extends CanvasLayer
class_name BattleUI

@export var hero_stats: HeroStats : set = _set_hero_stats

@onready var hand: Hand = %Hand
@onready var mana_ui: ManaUI = $ManaUI
@onready var end_turn_button: Button = %EndTurnButton

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)

func _set_hero_stats(value: HeroStats) -> void:
	hero_stats = value
	mana_ui.hero_stats = hero_stats
	hand.hero_stats = hero_stats

func _on_end_turn_button_pressed() -> void:
	end_turn_button.disabled = true
	Events.player_turn_ended.emit()

func _on_player_hand_drawn() -> void:
	end_turn_button.disabled = false
