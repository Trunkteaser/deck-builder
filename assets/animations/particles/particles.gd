extends GPUParticles2D
class_name Particles

func start(dir: Vector2, settings: ParticleSettings) -> void:
	process_material.direction = Vector3(dir.x, dir.y, 0)
	if settings:
		amount = settings.amount
		modulate = settings.color
		texture = settings.texture
	emitting = true
	await finished
	queue_free()
	
