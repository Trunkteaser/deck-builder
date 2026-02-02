extends Control
class_name ManaIcon

@onready var texture_rect: TextureRect = $TextureRect

func change_icon(icon: Texture2D) -> void:
	texture_rect.texture = icon
