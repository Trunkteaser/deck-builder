extends CenterContainer
class_name CardDisplay

const BASE_STYLEBOX := preload("uid://1ca5n2amt2on")
const HOVER_STYLEBOX := preload("uid://cg3od0rql0v1o")

@export var card_data: CardData : set = set_card

@onready var panel: Panel = %Panel
@onready var cost: Label = %Cost
@onready var card_name: Label = %Name
@onready var art: TextureRect = %Art
@onready var description: RichTextLabel = %Description


func set_card(new_card: CardData) -> void:
	if not is_node_ready():
		await ready
	card_data = new_card
	set_card_visuals()

func set_card_visuals() -> void:
	if not card_data:
		return
	art.texture = card_data.art
	card_name.text = card_data.name
	cost.text = str(card_data.cost)
	description.text = "[center]" + card_data.description + "[/center]"

func _on_visuals_mouse_entered() -> void:
	panel.set("theme_override_styles/panel", HOVER_STYLEBOX)


func _on_visuals_mouse_exited() -> void:
	panel.set("theme_override_styles/panel", BASE_STYLEBOX)


func _on_visuals_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		pass # Replace with function body.
