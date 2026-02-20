extends VFX

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start(sfx: AudioStream) -> void:
	animation_player.get_animation("green_rings").audio_track_set_key_stream(1, 0, sfx)
	animation_player.play("green_rings")
	await animation_player.animation_finished
	queue_free()
