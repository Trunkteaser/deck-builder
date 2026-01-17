extends Resource
class_name RunStats

signal inspiration_changed

const STARTING_INSPIRATION := 70
const BASE_CARD_REWARDS := 3
const BASE_ORDINARY_WEIGHT := 6.0
const BASE_REMARKABLE_WEIGHT := 3.7
const BASE_VISIONARY_WEIGHT := 0.3

@export var inspiration := STARTING_INSPIRATION : set = set_inspiration

func set_inspiration(new_amount: int) -> void:
	inspiration = new_amount
	inspiration_changed.emit()
