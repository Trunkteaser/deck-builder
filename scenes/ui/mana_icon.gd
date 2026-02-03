extends Control
class_name ManaIcon

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var texture_rect: TextureRect = $TextureRect
@onready var mana_animation: AnimatedSprite2D = $ManaAnimation
var last_animation: String

func _ready() -> void:
	await get_tree().process_frame
	mana_animation.play("idle")
	#mana_animation.play("fill")
	#last_animation = "fill"

func idle() -> void:
	mana_animation.play("idle")
	last_animation = "idle"

func change_icon(icon: Texture2D) -> void:
	texture_rect.texture = icon

func _on_mana_animation_animation_finished() -> void:
	if last_animation != "empty":
		idle()
#
func empty() -> void:
	sprite_2d.show()
	mana_animation.hide()
	#mana_animation.play("empty")
	#last_animation = "empty"
