@icon("res://assets/sprites/map.png")
extends Resource
class_name Phobia

@export var name: String
@export_multiline var description: String
@export var battle_stats_pool: BattleStatsPool
#@export var event_pool: EventPool
@export var line_sprite: Texture2D
## NOT_ASSIGNED, MONSTER, ELITE, SHOP, BOSS.
@export var map_node_icons: Dictionary = {
	Room.Type.NOT_ASSIGNED: null,
	Room.Type.MONSTER: preload("uid://0ugwlkehhsvv"),
	Room.Type.ELITE: preload("uid://brbvmboehsopp"),
	Room.Type.SHOP: preload("uid://ciloqb5micr74"),
	Room.Type.BOSS: preload("uid://d3hxorv3utoot")}
@export var battle_background: Texture2D
