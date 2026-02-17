extends Node

#region Preloads.
const STAB_VFX = preload("uid://c5fewocyppil3")
const STAB_SFX = preload("uid://ueoneelwrxii")

const LIGHTNING_BOLT_VFX = preload("uid://b7wk66mo71cuu")
const LIGHTNING_BOLT_SFX = preload("uid://cvyh01tlq60td")
#endregion

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
