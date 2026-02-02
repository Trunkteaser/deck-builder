extends Resource
class_name UnitStats

signal stats_changed

@export var max_health: int = 20
@export var art: Texture2D

var health: int : set = set_health
var block: int : set = set_block
var position: Vector2

func set_health(value: int) -> void:
	health = clampi(value, 0, max_health)
	stats_changed.emit()

func set_block(value: int) -> void:
	block = clampi(value, 0, 999)
	stats_changed.emit()

func take_damage(damage: int) -> void:
	if damage <= 0:
		return
	
	var incoming_damage = damage
	damage = clampi(damage - block, 0, damage)
	block = clampi(block - incoming_damage, 0, block)
	health -= damage
	Events.damage_taken.emit(damage, position)

func heal(amount: int) -> void:
	health += amount

func create_instance() -> Resource:
	var instance: UnitStats = self.duplicate()
	instance.health = max_health
	instance.block = 0
	return instance
	
