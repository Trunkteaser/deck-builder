extends Area2D
class_name MapRoom

# TODO Add phobia icons as constants too. One dictionary per phobia?
signal selected(room: Room)
const ICONS := {
	Room.Type.NOT_ASSIGNED: null,
	Room.Type.MONSTER: preload("uid://0ugwlkehhsvv"),
	Room.Type.ELITE: preload("uid://brbvmboehsopp"),
	Room.Type.SHOP: preload("uid://ciloqb5micr74"),
	Room.Type.BOSS: preload("uid://d3hxorv3utoot")}

@onready var line_2d: Line2D = $Visuals/Line2D
@onready var sprite_2d: Sprite2D = $Visuals/Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var available := false : set = set_available
var room: Room : set = set_room

#func _ready() -> void:
	#var test_room := Room.new()
	#test_room.type = Room.Type.BOSS
	#test_room.position = Vector2(150,150)
	#room = test_room
	#
	#await get_tree().create_timer(3).timeout
	#available = true

func set_available(new_value: bool) -> void:
	available = new_value
	if available:
		animation_player.play("highlight")
	elif not room.selected:
		animation_player.play("RESET") # Add in "dead room" animation?

func set_room(new_room: Room) -> void:
	room = new_room
	position = room.position
	#line_2d.rotation_degrees = randi_range(0, 360)
	sprite_2d.texture = ICONS[room.type] # Need to add [0]?

func show_selected() -> void:
	line_2d.modulate = Color.WHITE

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not available or not event.is_action_pressed("left_mouse"):
		return
	room.selected = true
	animation_player.play("select")

func _on_map_room_selected() -> void: # Called by animation player.
	selected.emit(room)
