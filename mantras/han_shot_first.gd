extends Mantra

const GUN_SFX = preload("uid://v8cw3s0bcm4r")

func activate_mantra(mantra_ui: MantraUI) -> void:
	var enemies := mantra_ui.get_tree().get_nodes_in_group("enemies")
	Apply.damage(enemies, 2, Modifier.Type.NO_MODIFIER)
	SFXPlayer.play(GUN_SFX)
	mantra_ui.flash()
