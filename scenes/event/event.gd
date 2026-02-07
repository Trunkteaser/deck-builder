extends Control
class_name Event

# Injected by Run.
@export var event_data: EventData : set = set_event_data
@export var hero_stats: HeroStats


@onready var art: TextureRect = %Art
@onready var title: Label = %Title
@onready var text: RichTextLabel = %Text
@onready var options: VBoxContainer = %Options
@export var option_1: Button
@export var label_1: RichTextLabel
@export var option_2: Button 
@export var label_2: RichTextLabel
@export var option_3: Button
@export var label_3: RichTextLabel 
@export var option_4: Button
@export var label_4: RichTextLabel 

func set_event_data(new_event: EventData) -> void:
	if not is_node_ready():
		await ready
	event_data = new_event
	update_event()

func update_event() -> void:
	art.texture = event_data.art
	title.text = event_data.title 
	text.text = event_data.text
	label_1.text = event_data.option_1
	label_2.text = event_data.option_2
	label_3.text = event_data.option_3
	label_4.text = event_data.option_4
	for option in options.get_children():
		if option.get_index() >= event_data.option_count:
			option.hide()

func _on_option_1_pressed() -> void:
	event_data.option_1_chosen()

func _on_option_2_pressed() -> void:
	event_data.option_2_chosen()

func _on_option_3_pressed() -> void:
	event_data.option_3_chosen()

func _on_option_4_pressed() -> void:
	event_data.option_4_chosen()


func _on_label_1_resized() -> void:
	if option_1.custom_minimum_size.y < label_1.size.y:
		option_1.custom_minimum_size.y = label_1.size.y

func _on_label_2_resized() -> void:
	if option_2.custom_minimum_size.y < label_2.size.y:
		option_2.custom_minimum_size.y = label_2.size.y

func _on_label_3_resized() -> void:
	if option_3.custom_minimum_size.y < label_3.size.y:
		option_3.custom_minimum_size.y = label_3.size.y

func _on_label_4_resized() -> void:
	if option_4.custom_minimum_size.y < label_4.size.y:
		option_4.custom_minimum_size.y = label_4.size.y
