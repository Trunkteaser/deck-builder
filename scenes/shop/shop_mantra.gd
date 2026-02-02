extends VBoxContainer
class_name ShopMantra

const BUY_SFX = preload("uid://cmjxae5tcff0")

@export var mantra: Mantra : set = set_mantra

@onready var mantra_ui: MantraUI = %MantraUI
@onready var price_label: Label = %PriceLabel

var cost: int = 0
var current_inspiration: int = 0

func update_buyable(run_stats: RunStats) -> void:
	current_inspiration = run_stats.inspiration
	if current_inspiration >= cost:
		price_label.remove_theme_color_override("font_color")
		modulate.a = 1
	else:
		price_label.add_theme_color_override("font_color", Color.RED)
		modulate.a = 0.3

func set_mantra(new_mantra) -> void:
	if not is_node_ready():
		await ready
	mantra = new_mantra
	mantra_ui.mantra = mantra
	tooltip_text = mantra.tooltip
	cost = randi_range(100, 300)
	price_label.text = str(cost)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		if current_inspiration < cost: 
			return	
		SFXPlayer.play(BUY_SFX)
		Events.shop_mantra_bought.emit(mantra, cost)
		queue_free()
