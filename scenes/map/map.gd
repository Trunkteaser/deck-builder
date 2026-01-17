extends Control
class_name Map



func _on_button_pressed() -> void:
	Events.map_exited.emit()
