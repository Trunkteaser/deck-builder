extends Control

# TODO Check which Mantras are already owned. Do not offer those.

@export var draftable_cards: CardPile
@export var shop_only_cards: CardPile
@export var buyable_mantras: MantraPile

@onready var animation_player: AnimationPlayer = $DecorationLayer/AnimationPlayer
@onready var cards: Control = %Cards
@onready var mantras: Control = %Mantras

var cards_for_sale: Array[CardData]
var mantras_for_sale: Array[Mantra]

func _ready() -> void:
	animation_player.play("vortex_rotation")
	choose_shop_cards()
	choose_shop_mantras()

func choose_shop_cards() -> void:
	cards_for_sale.clear()
	var possible_cards: Array[CardData] = draftable_cards.cards
	possible_cards.append_array(shop_only_cards.cards)
	if possible_cards.size() < 8:
		return
	while cards_for_sale.size() < 8:
		var card_candidate: CardData = possible_cards.pick_random()
		if not cards_for_sale.has(card_candidate):
			cards_for_sale.append(card_candidate)
	_assign_shop_cards()

func _assign_shop_cards() -> void:
	var shop_cards := cards.get_children()
	for shop_card: ShopCard in shop_cards:
		shop_card.card_data = cards_for_sale[shop_cards.find(shop_card)]

func choose_shop_mantras() -> void:
	mantras_for_sale.clear()
	var possible_mantras: Array[Mantra] = buyable_mantras.mantras
	if possible_mantras.size() < 3:
		return
	while mantras_for_sale.size() < 3:
		var mantra_candidate: Mantra = possible_mantras.pick_random()
		if not mantras_for_sale.has(mantra_candidate):
			mantras_for_sale.append(mantra_candidate)
	_assign_shop_mantras()

func _assign_shop_mantras() -> void:
	var shop_mantras := mantras.get_children()
	for shop_mantra in shop_mantras:
		shop_mantra.mantra = mantras_for_sale[shop_mantras.find(shop_mantra)]

func _on_button_pressed() -> void:
	Events.shop_exited.emit()
