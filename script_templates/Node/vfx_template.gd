extends VFX

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start(sfx: AudioStream) -> void:
	animation_player.get_animation("anim_name").audio_track_set_key_stream(1, 0, sfx)
	animation_player.play("anim_name")
	await animation_player.animation_finished
	queue_free()
