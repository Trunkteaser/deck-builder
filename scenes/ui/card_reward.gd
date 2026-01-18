extends CenterContainer
class_name CardReward

#signal card_reward_selected(card_data: CardData)

const BASE_STYLEBOX := preload("uid://1ca5n2amt2on")
const HOVER_STYLEBOX := preload("uid://cg3od0rql0v1o")

@export var card_data: CardData : set = set_card

@onready var visuals: CardVisuals = $Visuals

func set_card(new_card: CardData) -> void:
	if not is_node_ready():
		await ready
	card_data = new_card
	visuals.card_data = card_data

func _on_visuals_mouse_entered() -> void:
	visuals.panel.set("theme_override_styles/panel", HOVER_STYLEBOX)

func _on_visuals_mouse_exited() -> void:
	visuals.panel.set("theme_override_styles/panel", BASE_STYLEBOX)

func _on_visuals_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		#card_reward_selected.emit(card_data)
		Events.card_reward_selected.emit(card_data)
