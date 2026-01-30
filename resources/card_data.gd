@icon("res://assets/sprites/axe.png")
extends Resource
class_name CardData

enum Target {SINGLE_ENEMY, SELF, ALL_ENEMIES, EVERYONE}
enum Rarity {ORDINARY, REMARKABLE, VISIONARY}
enum Type {VIOLENCE, RESTRAINT, OBSESSION}

const RARITY_COLORS := {
	CardData.Rarity.ORDINARY: Color.GRAY,
	CardData.Rarity.REMARKABLE: Color.CORNFLOWER_BLUE,
	CardData.Rarity.VISIONARY: Color.GOLD}

@export_group("Visual")
@export var name: String
@export var rarity: Rarity
@export var art: Texture2D
@export_multiline var description: String
@export var sfx: AudioStream

@export_category("Attributes")
@export var type: Type
@export var cost: int = 1
@export var target: Target
@export var forget: bool = false

var hero: Array[Node] # For secondary self-targeting purposes.
var tree: SceneTree
var enemies: Array[Node]

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY

func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets: # Empty array.
		return []
	
	tree = targets[0].get_tree()
	
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("hero")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("hero") + tree.get_nodes_in_group("enemies")
		_:
			return []

func play(targets: Array[Node], hero_stats: HeroStats, modifiers: ModifierHandler) -> void:
	Events.card_played.emit(self)
	hero_stats.mana -= cost
	
	tree = targets[0].get_tree()
	hero = get_self(targets)
	enemies = tree.get_nodes_in_group("enemies")
	# Modifiers could be var in CardData instead of passed as argument.
	# Nah argument is good, then you remember to use it.
	
	if is_single_targeted():
		apply_effects(targets, modifiers)
	else:
		apply_effects(_get_targets(targets), modifiers)

func apply_effects(_targets: Array[Node], _modifiers: ModifierHandler) -> void:
	pass

func get_self(_targets: Array[Node]) -> Array[Node]: # Experimental, so I can hit enemy and then myself.
	# Could make the play function save self as a variable.
	# Then I won't have to call this method, but can simply access the hero.
	# like var hero: Array[Node] = [] <- set by play func.
	return tree.get_nodes_in_group("hero")

func wait(duration: float) -> Signal:
	return tree.create_timer(duration).timeout

func get_default_description() -> String:
	return description

func get_updated_description(_hero_modifiers: ModifierHandler, _enemy_modifiers: ModifierHandler) -> String:
	return description
