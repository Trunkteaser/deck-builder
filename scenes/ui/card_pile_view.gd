extends Control
class_name CardPileView

const CARD_DISPLAY_SCENE := preload("uid://c8aw4ikafti1e")

@export var card_pile: CardPile

@onready var title: Label = %Title
@onready var cards: GridContainer = %Cards
@onready var back_button: Button = %BackButton

func _ready() -> void:
	for card_display: CardDisplay in cards.get_children():
		card_display.queue_free() # Might have some children for testing.

func show_current_view(new_title: String, randomized: bool = false) -> void:
	for card_display: CardDisplay in cards.get_children():
		card_display.queue_free()
	title.text = new_title
	_update_view.call_deferred(randomized)

func _update_view(randomized: bool) -> void:
	if not card_pile:
		return
	
	var all_cards := card_pile.cards.duplicate()
	if randomized:
		all_cards.shuffle()
	
	for card_data: CardData in all_cards:
		var new_card: CardDisplay = CARD_DISPLAY_SCENE.instantiate()
		cards.add_child(new_card)
		new_card.card_data = card_data
		
	show()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		hide()

func _on_back_button_pressed() -> void:
	hide()

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		hide()
