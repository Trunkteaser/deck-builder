extends VFX

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start(sfx: AudioStream) -> void:
	animation_player.get_animation("lightning_bolt").audio_track_set_key_stream(1, 0, sfx)
	animation_player.play("lightning_bolt")
	await animation_player.animation_finished
	queue_free()
