extends VBoxContainer
class_name ShopCard

const BUY_SFX = preload("uid://bwonltvbchlj")

@export var card_data: CardData : set = set_card_data

@onready var card_display: CardDisplay = $CardContainer/CardDisplay
@onready var price_label: Label = %PriceLabel

var cost: int = 0
var current_inspiration: int = 0

func _ready() -> void:
	card_display.visuals.mouse_filter = Control.MOUSE_FILTER_IGNORE

func update_buyable(run_stats: RunStats) -> void:
	current_inspiration = run_stats.inspiration
	if current_inspiration >= cost:
		price_label.remove_theme_color_override("font_color")
		modulate.a = 1
	else:
		price_label.add_theme_color_override("font_color", Color.RED)
		modulate.a = 0.3

func set_card_data(new_card: CardData) -> void:
	if not is_node_ready():
		await ready
	card_data = new_card
	card_display.card_data = card_data
	match card_data.rarity:
		CardData.Rarity.ORDINARY:
			cost = randi_range(50, 150)
		CardData.Rarity.REMARKABLE:
			cost = randi_range(100, 200)
		CardData.Rarity.VISIONARY:
			cost = randi_range(150, 250)
	price_label.text = str(cost)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		if current_inspiration < cost: 
			return	
		SFXPlayer.play(BUY_SFX)
		Events.shop_card_bought.emit(card_data, cost)
		queue_free()

func _on_mouse_entered() -> void:
	card_display._on_visuals_mouse_entered()

func _on_mouse_exited() -> void:
	card_display._on_visuals_mouse_exited()
