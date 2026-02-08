extends Node
class_name MapGenerator

const X_DIST := 50 # 50 is good with 10 floors.
const Y_DIST := 35 # 
const PLACEMENT_RANDOMNESS := 8
const FLOORS := 10
const MAP_WIDTH := 7
const PATHS := 6
const MONSTER_ROOM_WEIGHT := 10.0
const SHOP_ROOM_WEIGHT := 2.0
const EVENT_ROOM_WEIGHT := 4.0
const ELITE_ROOM_WEIGHT := 2.0

@export var battle_stats_pool: BattleStatsPool
@export var event_pool: EventPool

# TODO Add in other rooms here.
var random_room_type_weights := {
	Room.Type.MONSTER: 0.0,
	Room.Type.ELITE: 0.0,
	Room.Type.SHOP: 0.0,
	Room.Type.EVENT: 0.0,}
var random_room_type_total_weight := 0
var map_data: Array[Array] # Outer is floors, inner is rooms on floors.

func generate_map() -> Array[Array]:
	map_data = _generate_initial_grid()
	var starting_points := _get_random_starting_points()
	for j in starting_points: # For each starting point...
		var current_j := j
		for i in FLOORS - 1: # ...build a path to the top.
			current_j = _setup_connection(i, current_j)
	battle_stats_pool.setup()
	_setup_boss_room()
	_setup_random_room_weights()
	_setup_room_types()
	
	return map_data

func _generate_initial_grid() -> Array[Array]:
	var grid: Array[Array] = []
	for i in FLOORS: # By default 15.
		var flooor: Array[Room] = []
		for j in MAP_WIDTH: # By default 7.
			var room := Room.new()
			var offset := Vector2(randf(), randf()) * PLACEMENT_RANDOMNESS
			# Original is (j * X_DIST, i * -Y_DIST).
			room.position = Vector2(i * X_DIST, j * Y_DIST) + offset
			room.row = i
			room.column = j
			room.next_rooms = []
			# Boss room.
			if i == FLOORS - 1:
				room.position.x = (i + 1) * X_DIST # +1 is extra big gap.
			flooor.append(room)
		grid.append(flooor)
	return grid

func _get_random_starting_points() -> Array[int]:
	var y_coordinates: Array[int] # Why is this called y_coordinates??
	var unique_points: int = 0
	while unique_points < 3:
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
		if before_boss.next_rooms: # Has next rooms, ie is being used. Shouldnt it check size > 0?
			before_boss.next_rooms = []
			before_boss.next_rooms.append(boss_room)
	boss_room.type = Room.Type.BOSS
	boss_room.battle_stats = battle_stats_pool.get_random_battle_for_tier(BattleStats.Tier.BOSS)

func _setup_random_room_weights() -> void:
	random_room_type_weights[Room.Type.MONSTER] = MONSTER_ROOM_WEIGHT
	random_room_type_weights[Room.Type.ELITE] = MONSTER_ROOM_WEIGHT + ELITE_ROOM_WEIGHT
	random_room_type_weights[Room.Type.SHOP] = MONSTER_ROOM_WEIGHT + ELITE_ROOM_WEIGHT + SHOP_ROOM_WEIGHT
	random_room_type_weights[Room.Type.EVENT] = MONSTER_ROOM_WEIGHT + ELITE_ROOM_WEIGHT + SHOP_ROOM_WEIGHT + EVENT_ROOM_WEIGHT
	# Total is equal to the last one in the list above.
	random_room_type_total_weight = random_room_type_weights[Room.Type.EVENT]

func _setup_room_types() -> void:
	# First floor is always a battle.
	for room: Room in map_data[0]:
		if room.next_rooms.size() > 0:
			room.type = Room.Type.MONSTER
			room.battle_stats = battle_stats_pool.get_random_battle_for_tier(BattleStats.Tier.EASY)
	# Can add other guaranteed floors here, like above.
	for flooor in map_data:
		for room: Room in flooor:
			for next_room: Room in room.next_rooms:
				if next_room.type == Room.Type.NOT_ASSIGNED:
					_set_room_randomly(next_room)

func _set_room_randomly(room: Room) -> void:
	var elite_below_4 := true
	var consecutive_elite := true
	var consecutive_shop := true
	# Can add other flags.
	var type_candidate: Room.Type
	while elite_below_4 or consecutive_elite or consecutive_shop:
		type_candidate = _get_random_room_type_by_weight()
		var is_elite := type_candidate == Room.Type.ELITE
		var has_elite_parent := _room_has_parent_of_type(room, Room.Type.ELITE)
		var is_shop := type_candidate == Room.Type.SHOP
		var has_shop_parent := _room_has_parent_of_type(room, Room.Type.SHOP)
		elite_below_4 = is_elite and room.row < 3
		consecutive_elite = is_elite and has_elite_parent
		consecutive_shop = is_shop and has_shop_parent
	room.type = type_candidate
	
	if type_candidate == Room.Type.MONSTER:
		var tier_for_monster_rooms := BattleStats.Tier.EASY
		if room.row > 1:
			tier_for_monster_rooms = BattleStats.Tier.NORMAL
		room.battle_stats = battle_stats_pool.get_random_battle_for_tier(tier_for_monster_rooms)
	elif type_candidate == Room.Type.ELITE:
		room.battle_stats = battle_stats_pool.get_random_battle_for_tier(BattleStats.Tier.ELITE)
	elif type_candidate == Room.Type.EVENT:
		var event: EventData = event_pool.events.pick_random()
		room.event_data = event
		# TODO Remove event duplicates.
		#event_pool.events.erase(event)

func _room_has_parent_of_type(room: Room, type: Room.Type) -> bool:
	var parents: Array[Room] = []
	# Left parent.
	if room.column > 0 and room.row > 0:
		var parent_candidate: Room = map_data[room.row - 1][room.column - 1]
		if parent_candidate.next_rooms.has(room):
			parents.append(parent_candidate)
	# Middle parent.
	if room.row > 0:
		var parent_candidate: Room = map_data[room.row - 1][room.column]
		if parent_candidate.next_rooms.has(room):
			parents.append(parent_candidate)
	# Right parent.
	if room.column < MAP_WIDTH-1 and room.row > 0:
		var parent_candidate: Room = map_data[room.row - 1][room.column + 1]
		if parent_candidate.next_rooms.has(room):
			parents.append(parent_candidate)
	for parent: Room in parents:
		if parent.type == type:
			return true
	return false
	
func _get_random_room_type_by_weight() -> Room.Type:
	var roll := randf_range(0.0, random_room_type_total_weight)
	for type: Room.Type in random_room_type_weights:
		if random_room_type_weights[type] > roll:
			return type
	return Room.Type.MONSTER
	
