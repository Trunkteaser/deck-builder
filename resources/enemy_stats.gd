@icon("res://assets/sprites/sludge lord boss.png")
extends UnitStats
class_name EnemyStats

@export var ai: PackedScene # TODO Decide if I like this approach.

# If I we're to do it differently...
# initial act function or whatever that gets called...
# having the actions as resources or nodes or something is useful, makes setting intents more practical
