@icon("res://assets/sprites/sludge lord boss.png")
extends UnitStats
class_name EnemyStats

@export var ai: PackedScene # TODO Decide if I like this approach.

#func take_damage(damage: int) -> void:
	#super.take_damage(damage)
	#

# If I we're to do it differently...
# initial act function or whatever that gets called...
# having the actions as resources or nodes or something is useful, makes setting intents more practical
