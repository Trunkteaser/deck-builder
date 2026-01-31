extends VBoxContainer
class_name ShopCard

@export var card_data: CardData : set = set_card_data

@onready var card_display: CardDisplay = $CardContainer/CardDisplay
@onready var price_label: RichTextLabel = %PriceLabel

func set_card_data(new_card: CardData) -> void:
	card_data = new_card
	card_display.card_data = card_data
