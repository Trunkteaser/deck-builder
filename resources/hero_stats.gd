@icon("res://assets/sprites/hero hat.png")
extends UnitStats
class_name HeroStats

signal mana_changed

@export var name: String
@export var starting_deck: CardPile
@export var draftable_cards: CardPile
@export var cards_per_turn: int
@export var max_mana: int
@export var innate_mantra: Mantra

var mana: int : set = set_mana
var deck: CardPile
var discard_pile: CardPile
var draw_pile: CardPile

func set_mana(value: int) -> void:
	mana = value
	stats_changed.emit()
	mana_changed.emit()

func reset_mana() -> void:
	mana = max_mana
	

func take_damage(damage: int) -> void:
	var initial_health := health
	super.take_damage(damage)
	if initial_health > health:
		Events.player_damaged.emit()

func can_play_card(card: CardData) -> bool:
	return mana >= card.cost

func create_instance() -> Resource:
	var instance: HeroStats = self.duplicate() # Not deep?
	instance.health = max_health
	instance.block = 0
	instance.reset_mana()
	instance.deck = instance.starting_deck.duplicate() # Ah we never modify the starting deck.
	instance.draw_pile = CardPile.new()
	instance.discard_pile = CardPile.new()
	return instance
