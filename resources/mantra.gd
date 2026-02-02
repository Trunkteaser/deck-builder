@icon("res://assets/sprites/speech bubble.png")
extends Resource
class_name Mantra

enum Type {START_OF_TURN, START_OF_COMBAT, END_OF_TURN, END_OF_COMBAT, EVENT_BASED}
enum Owner {ALL, WITCH, SHRIKE}

@export var name: String
@export var type: Type
@export var owner: Owner
@export var innate_mantra: bool = false 
@export var icon: Texture2D
@export_multiline var tooltip: String

func initialize_mantra(_mantra_ui: MantraUI) -> void:
	pass

func activate_mantra(_mantra_ui: MantraUI) -> void:
	pass

# EventBased needs to disconnect from EventBus.
func deactivate_mantra(_mantra_ui: MantraUI) -> void:
	pass

# Can be overwritten to alter tooltip.
func get_tooltip() -> String:
	return tooltip

func can_appear_as_reward(hero: HeroStats) -> bool:
	if innate_mantra:
		return false
	if owner == Owner.ALL:
		return true
	var mantra_owner_name: String = Owner.keys()[owner].to_lower()
	var hero_name: String = hero.name.to_lower()
	return mantra_owner_name == hero_name
