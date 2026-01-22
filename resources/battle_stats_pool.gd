@icon("res://assets/sprites/octopus.png")
extends Resource
class_name BattleStatsPool

@export var pool: Array[BattleStats]

var total_weights_by_tier := {
	BattleStats.Tier.EASY: 0.0,
	BattleStats.Tier.NORMAL: 0.0,
	BattleStats.Tier.ELITE: 0.0,
	BattleStats.Tier.BOSS: 0.0}

func _get_all_battles_for_tier(tier: BattleStats.Tier) -> Array[BattleStats]:
	return pool.filter(
		func(battle: BattleStats):
			return battle.tier == tier)

func _setup_weight_for_tier(tier: BattleStats.Tier) -> void:
	var battles := _get_all_battles_for_tier(tier)
	total_weights_by_tier[tier] = 0.0
	for battle: BattleStats in battles:
		total_weights_by_tier[tier] += battle.weight
		battle.accumulated_weight = total_weights_by_tier[tier]

func get_random_battle_for_tier(tier: BattleStats.Tier) -> BattleStats:
	var roll := randf_range(0.0, total_weights_by_tier[tier])
	var battles := _get_all_battles_for_tier(tier)
	for battle: BattleStats in battles:
		if battle.accumulated_weight > roll:
			return battle
	return null

func setup() -> void:
	_setup_weight_for_tier(BattleStats.Tier.EASY)
	_setup_weight_for_tier(BattleStats.Tier.NORMAL)
	_setup_weight_for_tier(BattleStats.Tier.ELITE)
	_setup_weight_for_tier(BattleStats.Tier.BOSS)
		
