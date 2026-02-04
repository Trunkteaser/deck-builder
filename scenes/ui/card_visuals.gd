@tool
extends Control
class_name CardVisuals

@export var card_data: CardData : set = set_card_data

@onready var panel: Panel = %Panel
@onready var cost: Label = %Cost
@onready var card_name: Label = %Name
@onready var art: TextureRect = %Art
@onready var description: RichTextLabel = %Description
@onready var rarity: Label = %Rarity

# TODO Add a dictionary with rarities + heroes as keys, and colors as values.

func set_card_data(new_card: CardData) -> void:
	if not is_node_ready():
		await ready
	card_data = new_card 
	set_card_visuals()
	set_card_description()

func set_card_visuals() -> void:
	if not card_data:
		return
	art.texture = card_data.art
	card_name.text = card_data.name
	cost.text = str(card_data.cost)
	rarity.modulate = CardData.RARITY_COLORS[card_data.rarity]
	#match card_data.rarity:
		#CardData.Rarity.ORDINARY:
			#rarity.text = "Ordinary"
		#CardData.Rarity.REMARKABLE:
			#rarity.text = "Remarkable"
		#CardData.Rarity.VISIONARY:
			#rarity.text = "Visionary"
	match card_data.type:
		CardData.Type.VIOLENCE:
			rarity.text = "VIOLENCE"
		CardData.Type.RESTRAINT:
			rarity.text = "RESTRAINT"
		CardData.Type.OBSESSION:
			rarity.text = "OBSESSION"
		CardData.Type.INTRUSION:
			rarity.text = "INTRUSION"

func set_card_description() -> void:
	if Engine.is_editor_hint():
		description.text = card_data.description
	description.text = "[center]" + card_data.get_default_description() + "[/center]"
