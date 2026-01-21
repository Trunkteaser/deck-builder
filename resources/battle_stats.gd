@icon("res://assets/sprites/fist.png")
extends Resource
class_name BattleStats

enum Tier {EASY, NORMAL, ELITE, BOSS}
@export var tier: Tier
@export_range(0.0, 10.0) var weight: float = 1
@export var gold_reward_min: int
@export var gold_reward_max: int
@export var enemies: PackedScene

var accumulated_weight: float = 0.0

func roll_gold_reward() -> int:
	return randi_range(gold_reward_min, gold_reward_max)
