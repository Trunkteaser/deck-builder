extends Node

var card: Control

func _ready() -> void:
	if get_child(2):
		card = get_child(2)

func _on_test_button_pressed() -> void:
	card.rotation_degrees += 2.0

func _on_test_button_2_pressed() -> void:
	card.scale *= 1.1
