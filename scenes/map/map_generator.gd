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
	var starting_points := _get_random_starting_points()
	for j in starting_points: # For each starting point...
		var current_j := j
		for i in FLOORS - 1: # ...build a path to the top.
			current_j = _setup_connection(i, current_j)
	_setup_boss_room()
	_setup_random_room_weights()
	_setup_room_types()
	
	
	var i := 0
	for flooor in map_data:
		print("floor %s" % i)
		var used_rooms = flooor.filter(
			func(room: Room): return room.next_rooms.size() > 0
		)
		print(used_rooms)
		i += 1
	
	return map_data

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

func _get_random_starting_points() -> Array[int]:
	var y_coordinates: Array[int] # Why is this called y_coordinates??
	var unique_points: int = 0
	while unique_points < 2:
		unique_points = 0
		y_coordinates = []
		for i in PATHS:
			var starting_point := randi_range(0, MAP_WIDTH - 1)
			if not y_coordinates.has(starting_point):
				unique_points += 1
			y_coordinates.append(starting_point)
	return y_coordinates

func _setup_connection(i: int, j: int) -> int:
	var next_room: Room = null # Hopefully legal to set as null.
	var current_room: Room = map_data[i][j]
	while not next_room or _would_cross_existing_path(i, j, next_room):
		var random_j := clampi(randi_range(j - 1, j + 1), 0, MAP_WIDTH - 1)
		next_room = map_data[i + 1][random_j]
	current_room.next_rooms.append(next_room)
	return next_room.column 
	# Returns the j-value of the next room, ie a singular connection.

func _would_cross_existing_path(i: int, j: int, room: Room) -> bool:
	# i and j are coordinates of current room, room is a candidate for connection.
	var left_neighbour: Room
	var right_neighbour: Room
	if j > 0: # Not at left edge of grid.
		left_neighbour = map_data[i][j - 1]
	if j < MAP_WIDTH - 1: # Not at right edge of grid.
		right_neighbour = map_data[i][j + 1]
	if right_neighbour and room.column > j: # If going towards the right neighbour.
		for next_room: Room in right_neighbour.next_rooms:
			if next_room.column < room.column:
				return true
	if left_neighbour and room.column < j: # If going towards the left neighbour.
		for next_room: Room in left_neighbour.next_rooms:
			if next_room.column > room.column:
				return true
	return false

func _setup_boss_room() -> void:
	var middle := floori(MAP_WIDTH * 0.5)
	var boss_room: Room = map_data[FLOORS - 1][middle]
	for j in MAP_WIDTH: # Connecting to the boss room.
		var before_boss: Room = map_data[FLOORS - 2][j]
		if before_boss.next_rooms: # Has next rooms, ie is being used.
			before_boss.next_rooms = []
			before_boss.next_rooms.append(boss_room)
	boss_room.type = Room.Type.BOSS

func _setup_random_room_weights() -> void:
	random_room_type_weights[Room.Type.MONSTER] = MONSTER_ROOM_WEIGHT
	random_room_type_weights[Room.Type.ELITE] = MONSTER_ROOM_WEIGHT + ELITE_ROOM_WEIGHT
	random_room_type_weights[Room.Type.SHOP] = MONSTER_ROOM_WEIGHT + ELITE_ROOM_WEIGHT + SHOP_ROOM_WEIGHT
	# Total is equal to the last one in the list above.
	random_room_type_total_weight = random_room_type_weights[Room.Type.SHOP]

func _setup_room_types() -> void:
	pass
