extends Node

@export var card: Control
@onready var hero: Hero = $"../Hero"

func _on_test_button_pressed() -> void:
	Apply.mana([hero], 1)
	pass

func _on_test_button_2_pressed() -> void:
	Apply.mana([hero], -1)
	pass
