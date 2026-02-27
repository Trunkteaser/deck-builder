extends Mood

var hero
const ANGER = preload("uid://bl7yry7rm0qru")

func apply_anger() -> void:
	Apply.mood([hero], ANGER, 1*stacks)

func remove_agitation() -> void:
	stacks = 0

func initialize_mood(target: Node) -> void:
	hero = target
	Events.player_damaged.connect(apply_anger)
	Events.enemy_turn_ended.connect(remove_agitation)
	pass

func get_tooltip() -> String:
	return tooltip % stacks
