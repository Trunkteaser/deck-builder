extends Node

const STAB_VFX = preload("uid://c5fewocyppil3")
const STAB_SFX = preload("uid://ueoneelwrxii")

## For no sfx, pass null as sfx.
func stab(pos: Vector2, sfx: AudioStream = STAB_SFX) -> void:
	var stab_vfx: StabVFX = STAB_VFX.instantiate()
	add_child(stab_vfx)
	stab_vfx.global_position = pos
	stab_vfx.start(sfx)

func external_vfx(vfx_scene: PackedScene, pos: Vector2, sfx: AudioStream = null) -> void:
	var vfx := vfx_scene.instantiate()
	add_child(vfx)
	vfx.global_position = pos
	vfx.start(sfx)
