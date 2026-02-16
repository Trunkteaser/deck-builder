extends Sprite2D
class_name StabVFX

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start(sfx: AudioStream) -> void:
	animation_player.get_animation("stab").audio_track_set_key_stream(1, 0, sfx)
	animation_player.play("stab")
	await animation_player.animation_finished
	queue_free()

#func start(sfx: bool = true) -> void:
	#animation_player.get_animation("stab").track_set_enabled(1, sfx)
	#animation_player.play("stab")
	#await animation_player.animation_finished
	#queue_free()
