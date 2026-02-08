extends Resource
class_name Room

enum Type {NOT_ASSIGNED, MONSTER, ELITE, SHOP, TREASURE, CAMPFIRE, HERMIT, BOSS, EVENT}

@export var type: Type
@export var row: int
@export var column: int
@export var position: Vector2
@export var next_rooms: Array[Room]
@export var selected: bool = false
@export var battle_stats: BattleStats # Only if monster, elite or boss.
@export var event_data: EventData # Only if event.

func _to_string() -> String: # For debugging.
	return "%s (%s)" % [column, Type.keys()[type][0]]
