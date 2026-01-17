extends CanvasLayer
class_name BattleUI

@export var hero_stats: HeroStats : set = _set_hero_stats

@onready var hand: Hand = %Hand
@onready var mana_ui: ManaUI = $ManaUI
@onready var end_turn_button: Button = %EndTurnButton
@onready var draw_pile_button: CardPileOpener = %DrawPileButton
@onready var discard_pile_button: CardPileOpener = %DiscardPileButton
@onready var draw_pile_view: CardPileView = %DrawPileView
@onready var discard_pile_view: CardPileView = %DiscardPileView

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	draw_pile_button.pressed.connect(draw_pile_view.show_current_view.bind("Draw Pile", true))
	discard_pile_button.pressed.connect(discard_pile_view.show_current_view.bind("Discard Pile"))

func initialize_card_pile_ui() -> void: # Called by battle.
	draw_pile_button.card_pile = hero_stats.draw_pile
	draw_pile_view.card_pile = hero_stats.draw_pile
	discard_pile_button.card_pile = hero_stats.discard_pile
	discard_pile_view.card_pile = hero_stats.discard_pile

func _set_hero_stats(value: HeroStats) -> void:
	hero_stats = value
	mana_ui.hero_stats = hero_stats
	hand.hero_stats = hero_stats

func _on_end_turn_button_pressed() -> void:
	end_turn_button.disabled = true
	Events.player_turn_ended.emit()

func _on_player_hand_drawn() -> void:
	end_turn_button.disabled = false
