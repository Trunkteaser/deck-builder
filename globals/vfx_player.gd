extends Node

#region Preloads.
const PARTICLE_SCENE = preload("uid://dniyxwrrtnae1")

const STAB_VFX = preload("uid://c5fewocyppil3")
const STAB_SFX = preload("uid://ueoneelwrxii")

const LIGHTNING_BOLT_VFX = preload("uid://b7wk66mo71cuu")
const LIGHTNING_BOLT_SFX = preload("uid://cvyh01tlq60td")

const GREEN_RING_VFX = preload("uid://bdm1b0bmm0pog")
const GREEN_RING_SFX = preload("uid://m84bkss5ugw1")

#endregion

func particles(pos: Vector2, dir: Vector2, settings: ParticleSettings) -> void:
	var new_particles: Particles = PARTICLE_SCENE.instantiate()
	add_child(new_particles)
	new_particles.global_position = pos
	new_particles.start(dir, settings)

func green_ring(pos:Vector2, sfx: AudioStream = GREEN_RING_SFX) -> void:
	var green_ring_vfx: VFX = GREEN_RING_VFX.instantiate()
	add_child(green_ring_vfx)
	green_ring_vfx.global_position = pos
	green_ring_vfx.start(sfx)

func lightning_bolt(pos: Vector2, sfx: AudioStream = LIGHTNING_BOLT_SFX) -> void:
	var lightning_bolt_vfx: VFX = LIGHTNING_BOLT_VFX.instantiate()
	add_child(lightning_bolt_vfx)
	lightning_bolt_vfx.global_position = pos
	lightning_bolt_vfx.start(sfx)

## For no sfx, pass null as sfx.
func stab(pos: Vector2, sfx: AudioStream = STAB_SFX) -> void:
	var stab_vfx: VFX = STAB_VFX.instantiate()
	add_child(stab_vfx)
	stab_vfx.global_position = pos
	stab_vfx.start(sfx)

func external_vfx(vfx_scene: PackedScene, pos: Vector2, sfx: AudioStream = null) -> void:
	var vfx: VFX = vfx_scene.instantiate()
	add_child(vfx)
	vfx.global_position = pos
	vfx.start(sfx)
