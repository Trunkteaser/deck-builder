extends VBoxContainer
class_name ShopMantra

@export var mantra: Mantra : set = set_mantra

@onready var mantra_ui: MantraUI = %MantraUI
@onready var price_label: RichTextLabel = %PriceLabel

func set_mantra(new_mantra) -> void:
	mantra = new_mantra
	mantra_ui.mantra = mantra
	tooltip_text = mantra.tooltip
	price_label.text = str(randi_range(50, 150))

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		print("check cost and add mantra")
		# add the mantra...
		pass
