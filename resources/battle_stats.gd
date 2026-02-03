@icon("res://assets/sprites/fist.png")
extends Resource
class_name BattleStats

enum Tier {EASY, NORMAL, ELITE, BOSS}
@export var tier: Tier
@export_range(0.0, 10.0) var weight: float = 1
@export var avg_insp_reward: int
@export var enemies: PackedScene

var accumulated_weight: float = 0.0

func roll_inspiration_reward() -> int:
	var min_reward: int = floori(avg_insp_reward*0.8)
	var max_reward: int = floori(avg_insp_reward*1.2)
	return randi_range(min_reward, max_reward)
