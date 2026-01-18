extends Node
class_name MapGenerator

const X_DIST := 30 # Gap between nodes on x-axis.
const Y_DIST := 25 # Gap between nodes on y-axis (between floors).
const PLACEMENT_RANDOMNESS := 5
const FLOORS := 15
const MAP_WIDTH := 7
const PATHS := 6
const MONSTER_ROOM_WEIGHT := 10.0
const SHOP_ROOM_WEIGHT := 2.0
const ELITE_ROOM_WEIGHT := 3.0

# TODO Add in other rooms here.
var random_room_type_weights := {
	Room.Type.MONSTER: 0.0,
	Room.Type.ELITE: 0.0,
	Room.Type.SHOP: 0.0,}
var random_room_type_total_weight := 0
var map_data: Array[Array] # Outer is floors, inner is rooms on floors.

func _ready() -> void:
	generate_map() # Testing.

func generate_map() -> Array[Array]:
	map_data = _generate_initial_grid()
	
	# For printing.
	var i := 0
	for flooor in map_data:
		print("floor %s:	%s" % [i, flooor])
		i += 1
	
	return []

func _generate_initial_grid() -> Array[Array]:
	var grid: Array[Array] = []
	for i in FLOORS: # By default 15.
		var flooor: Array[Room] = []
		for j in MAP_WIDTH: # By default 7.
			var room := Room.new()
			var offset := Vector2(randf(), randf()) * PLACEMENT_RANDOMNESS
			# TODO Simply swap X_DIST and -Y_DIST here for horizontal map.
			room.position = Vector2(j * X_DIST, i * -Y_DIST) + offset
			room.row = i
			room.column = j
			room.next_rooms = []
			# Boss room.
			if i == FLOORS - 1:
				room.position.y = (i + 1) * -Y_DIST # TODO This as well. +1 is extra big gap.
			flooor.append(room)
		grid.append(flooor)
	return grid
