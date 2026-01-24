extends Node
class_name HeroHandler

const HAND_DRAW_INTERVAL := 0.1
const HAND_DISCARD_INTERVAL := 0.1
const DRAW_SFX := preload("uid://bwonltvbchlj")

@export var hero_node: Hero
@export var hand: Hand

var hero: HeroStats

func _ready() -> void:
	Events.request_card_draw.connect(draw_cards) # Experimental.
	Events.card_played.connect(_on_card_played)

func start_battle(hero_stats: HeroStats) -> void:
	hero = hero_stats
	hero.draw_pile = hero.deck.duplicate(true)
	hero.draw_pile.shuffle()
	hero.discard_pile = CardPile.new()
	hero_node.mood_handler.moods_triggered.connect(_on_moods_triggered)
	start_turn()

func start_turn() -> void:
	hero.block = 0
	hero.reset_mana()
	if not hero_node:
		return
	hero_node.mood_handler.trigger_moods_by_type(Mood.TriggerType.START_OF_TURN)

func end_turn() -> void:
	hand.disable_hand()
	hero_node.mood_handler.trigger_moods_by_type(Mood.TriggerType.END_OF_TURN)

func draw_card() -> void:
	reshuffle_deck_from_discard()
	hand.add_card(hero.draw_pile.draw_card())
	SFXPlayer.play(DRAW_SFX)
	#reshuffle_deck_from_discard() # I don't necessarily mind hand being empty after draw?

func draw_cards(amount: int) -> void:
	var tween := create_tween()
	for i in amount:
		tween.tween_callback(draw_card) # Tween calling a function.
		tween.tween_interval(HAND_DRAW_INTERVAL) # With this frequency.
	tween.finished.connect(func(): Events.player_hand_drawn.emit())

func discard_cards() -> void:
	if hand.get_child_count() == 0:
		Events.player_hand_discarded.emit()
		return
	var tween := create_tween()
	for card in hand.get_children():
		tween.tween_callback(hero.discard_pile.add_card.bind(card.card_data)) # Adding to discard pile.
		tween.tween_callback(hand.discard_card.bind(card)) # Discarding the card.
		tween.tween_interval(HAND_DISCARD_INTERVAL)
	tween.finished.connect(func(): Events.player_hand_discarded.emit())

func reshuffle_deck_from_discard() -> void:
	if not hero.draw_pile.empty():
		return
	while not hero.discard_pile.empty():
		hero.draw_pile.add_card(hero.discard_pile.draw_card())
	hero.draw_pile.shuffle()

func _on_card_played(card_data: CardData) -> void:
	hero.discard_pile.add_card(card_data)

func _on_moods_triggered(trigger_type: Mood.TriggerType) -> void:
	match trigger_type:
		Mood.TriggerType.START_OF_TURN:
			draw_cards(hero.cards_per_turn)
		Mood.TriggerType.END_OF_TURN:
			discard_cards()
