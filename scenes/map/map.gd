extends Control
class_name Map

const MAP_ROOM = preload("uid://bdy0nbcn0a2s1")
const MAP_LINE = preload("uid://d0mxwcdup8hlw")

@onready var map_generator: MapGenerator = $MapGenerator
@onready var visuals: Control = $Visuals
@onready var lines: Control = %Lines
@onready var rooms: Control = %Rooms

var map_data: Array[Array]
var floors_climbed: int
var last_room: Room

func generate_new_map() -> void:
	floors_climbed = 0
	map_data = map_generator.generate_map()
	create_map_visuals()

func create_map_visuals() -> void:
	for current_floor: Array in map_data:
		for room: Room in current_floor:
			if room.next_rooms.size() > 0:
				_spawn_room(room)
	# Boss room lacks next rooms, but still needs spawning.
	var middle := floori(MapGenerator.MAP_WIDTH * 0.5)
	_spawn_room(map_data[MapGenerator.FLOORS-1][middle])
	# Putting map in the middle of screen.
	var map_width := MapGenerator.X_DIST * (MapGenerator.MAP_WIDTH - 1)
	visuals.position.x = (get_viewport_rect().size.x - map_width)/3
	visuals.position.y = (get_viewport_rect().size.y)/4
	
func unlock_floor(which_floor: int = floors_climbed) -> void:
	for map_room: MapRoom in rooms.get_children():
		if map_room.room.row == which_floor:
			map_room.available = true

func unlock_next_rooms() -> void:
	for map_room: MapRoom in rooms.get_children():
		if last_room.next_rooms.has(map_room.room):
			map_room.available = true

func _spawn_room(room: Room) -> void:
	var new_map_room: MapRoom = MAP_ROOM.instantiate()
	rooms.add_child(new_map_room)
	new_map_room.room = room
	new_map_room.selected.connect(_on_map_room_selected)
	_connect_lines(room)
	if room.selected and room.row < floors_climbed: # For loading game.
		new_map_room.show_selected()

func _connect_lines(room: Room) -> void:
	if room.next_rooms.is_empty():
		return
	for next: Room in room.next_rooms:
		var new_map_line: Line2D = MAP_LINE.instantiate()
		new_map_line.add_point(room.position)
		new_map_line.add_point(next.position)
		lines.add_child(new_map_line)

func _on_map_room_selected(room: Room) -> void:
	for map_room: MapRoom in rooms.get_children():
		if map_room.room.row == room.row:
			map_room.available = false
	last_room = room
	floors_climbed += 1
	Events.map_exited.emit(room)
