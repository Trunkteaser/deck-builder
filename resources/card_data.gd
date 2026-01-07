@icon("res://assets/sprites/skill class icon.png")
extends Resource
class_name CardData

enum Target {SINGLE_ENEMY, SELF, ALL_ENEMIES, EVERYONE}
enum Type {ATTACK, SKILL, POWER}

@export_group("Visual")
@export var name: String
@export var art: Texture2D
@export_multiline var description: String

@export_category("Attributes")
@export var cost: int = 1
@export var target: Target

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY

func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets: # Empty array.
		return []
	
	var tree := targets[0].get_tree()
	
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("hero")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("hero") + tree.get_nodes_in_group("enemies")
		_:
			return []

func play(targets: Array[Node], hero_stats: HeroStats) -> void:
	Events.card_played.emit(self)
	hero_stats.mana -= cost
	if is_single_targeted():
		apply_effects(targets)
	else:
		apply_effects(_get_targets(targets))

func apply_effects(_targets: Array[Node]) -> void:
	pass

func get_self(targets: Array[Node]) -> Array[Node]: # Experimental, so I can hit enemy and then myself.
	# Could make the play function save self as a variable.
	# Then I won't have to call this method, but can simply access the hero.
	# like var hero: Array[Node] = [] <- set by play func.
	var tree := targets[0].get_tree()
	return tree.get_nodes_in_group("hero")
