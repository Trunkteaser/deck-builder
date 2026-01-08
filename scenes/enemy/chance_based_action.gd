@icon("res://assets/sprites/dice.png")
extends EnemyAction
class_name ChanceBasedAction

@export_range(0.0, 10.0) var chance_weight := 0.0

@onready var accumulated_weight := 0.0
