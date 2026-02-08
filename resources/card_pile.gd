@icon("res://assets/sprites/book.png")
extends Resource
class_name CardPile

signal card_pile_size_changed(cards_amount: int)

@export var cards: Array[CardData] = []

func empty() -> bool:
	return cards.is_empty()

func draw_card() -> CardData:
	var card = cards.pop_front()
	card_pile_size_changed.emit(cards.size())
	#if not Events.card_drawn.is_connected(card._on_card_drawn):
		#Events.card_drawn.connect(card._on_card_drawn)
	#Events.card_drawn.emit(card)
	#card.when_drawn()
	return card

func add_card(card: CardData) -> void:
	cards.append(card)
	card_pile_size_changed.emit(cards.size())

func remove_card(card: CardData) -> void:
	cards.erase(card)
	card_pile_size_changed.emit(cards.size())

func shuffle() -> void:
	cards.shuffle()

func clear() -> void:
	cards.clear()
	card_pile_size_changed.emit(cards.size())
	
func _to_string() -> String: # For printing out the contents of the array.
	var _card_strings: PackedStringArray = []
	for i in range(cards.size()):
		_card_strings.append("%s: %s" % [i + 1, cards[i].name])
	return "\n".join(_card_strings)
