extends Mood

const RAW = preload("uid://e3y8blx55fdt")
const SFX = preload("uid://hnpv6hjd7j5e")

func trigger_mood(target: Node) -> void:
	var enemies: Array = target.get_tree().get_nodes_in_group("enemies")
	Apply.mood(enemies, RAW, 2)
	SFXPlayer.play(SFX)
	mood_triggered.emit(self)
