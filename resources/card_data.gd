@icon("res://assets/sprites/axe.png")
extends Resource
class_name CardData

enum Target {SINGLE_ENEMY, SELF, ALL_ENEMIES, EVERYONE}
enum Rarity {ORDINARY, REMARKABLE, VISIONARY}
enum Type {VIOLENCE, RESTRAINT, OBSESSION, INTRUSION}

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
@export var retain: bool = false

# Injected or set up by HeroHandler.
var draw_pile: CardPile
var discard_pile: CardPile
var tree: SceneTree
var hero: Array[Node] # For secondary self-targeting purposes.
var enemies: Array[Node]
var hand: Hand

func setup_node_access(node: Node) -> void:
	tree = node.get_tree()
	hero = tree.get_nodes_in_group("hero")
	enemies = tree.get_nodes_in_group("enemies")
	hand = tree.get_first_node_in_group("hand")


func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY

func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets: # Empty array.
		return []
	#setup_node_access(targets[0])
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
	setup_node_access(targets[0])
	if is_single_targeted():
		apply_effects(targets, modifiers)
	else:
		apply_effects(_get_targets(targets), modifiers)

func wait(duration: float) -> Signal:
	return tree.create_timer(duration).timeout

func apply_effects(_targets: Array[Node], _modifiers: ModifierHandler) -> void:
	pass

func get_default_description() -> String:
	return description

func get_updated_description(_hero_modifiers: ModifierHandler, _enemy_modifiers: ModifierHandler) -> String:
	return description

# Called by HeroHandler.
func when_drawn() -> void:
	pass

# Called by Hand.
func when_discarded() -> void:
	pass

# Called by HeroHandler on all cards in hand eot.
# Secretly named when_still_in_hand_at_end_of_turn().
func when_retained() -> void:
	pass
