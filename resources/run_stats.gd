extends Resource
class_name RunStats

signal inspiration_changed

const STARTING_INSPIRATION := 70
const BASE_CARD_REWARDS := 3
const BASE_ORDINARY_WEIGHT := 6.0
const BASE_REMARKABLE_WEIGHT := 3.7
const BASE_VISIONARY_WEIGHT := 0.3

@export var inspiration := STARTING_INSPIRATION : set = set_inspiration
@export var card_rewards := BASE_CARD_REWARDS
@export_range(0.0, 10.0) var ordinary_weight := BASE_ORDINARY_WEIGHT
@export_range(0.0, 10.0) var remarkable_weight := BASE_REMARKABLE_WEIGHT
@export_range(0.0, 10.0) var visionary_weight := BASE_VISIONARY_WEIGHT

func set_inspiration(new_amount: int) -> void:
	inspiration = new_amount
	inspiration_changed.emit()

func reset_weights() -> void:
	ordinary_weight = BASE_ORDINARY_WEIGHT
	remarkable_weight = BASE_REMARKABLE_WEIGHT
	visionary_weight = BASE_VISIONARY_WEIGHT
	
