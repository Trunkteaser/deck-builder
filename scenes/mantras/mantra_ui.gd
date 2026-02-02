extends Control
class_name MantraUI

@export var mantra: Mantra : set = set_mantra

@onready var icon: TextureRect = $Icon
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func set_mantra(new_mantra: Mantra) -> void:
	if not is_node_ready():
		await ready
	mantra = new_mantra
	icon.texture = mantra.icon
	tooltip_text = mantra.get_tooltip()

func flash() -> void:
	animation_player.play("flash")

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		#print("mantra tooltip")
		pass
