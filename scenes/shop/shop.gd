extends Control

@onready var animation_player: AnimationPlayer = $DecorationLayer/AnimationPlayer

func _ready() -> void:
	animation_player.play("vortex_rotation")
func _on_button_pressed() -> void:
	Events.shop_exited.emit()
