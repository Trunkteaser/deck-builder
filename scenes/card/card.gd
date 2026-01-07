@tool
extends Control
class_name Card

signal reparent_requested(card: Card)

const SIZE := Vector2(75, 106)
const BASE_STYLE := preload("uid://1ca5n2amt2on")
const HOVER_STYLE := preload("uid://cg3od0rql0v1o")
const DRAG_STYLE := preload("uid://c336ntkuwrp1m")

@onready var panel: Panel = %Panel
@onready var cost: Label = %Cost
@onready var card_name: Label = %Name
@onready var art: TextureRect = %Art
@onready var description: RichTextLabel = %Description
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine
@onready var targets: Array[Node] = []
@onready var original_index := self.get_index()

@export var card_data: CardData : set = _set_card_data
@export var hero_stats: HeroStats : set = _set_hero_stats

var parent: Control
var tween: Tween
var playable = true : set = _set_playable
var disabled := false
# Could have constants for different card frames/styles that are set depending on variable in card_data.

func _ready() -> void:
	Events.card_aim_started.connect(_on_card_drag_or_aiming_started)
	Events.card_drag_started.connect(_on_card_drag_or_aiming_started)
	Events.card_aim_ended.connect(_on_card_drag_or_aiming_ended)
	Events.card_drag_ended.connect(_on_card_drag_or_aiming_ended)
	card_state_machine.init(self) # Initializes, and gives reference to self.

#region Passing all input and mouse events to the state machine.
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()
#endregion

func _set_card_data(new_card: CardData) -> void:
	if not is_node_ready():
		await ready
	card_data = new_card
	set_card_visuals()

func _set_hero_stats(value: HeroStats) -> void:
	hero_stats = value
	if not hero_stats.stats_changed.is_connected(_on_hero_stats_changed):
		hero_stats.stats_changed.connect(_on_hero_stats_changed)

func _set_playable(value: bool) -> void:
	playable = value
	if not playable:
		cost.add_theme_color_override("font_color", Color.RED)
		panel.modulate.a = 0.5
	else:
		cost.remove_theme_color_override("font_color")
		panel.modulate.a = 1

func set_card_visuals() -> void:
	if not card_data:
		return
	art.texture = card_data.art
	card_name.text = card_data.name
	cost.text = str(card_data.cost)
	description.text = "[center]" + card_data.description + "[/center]"
	# TODO Consider generating description.

func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position, duration)

func play() -> void:
	if not card_data:
		return
	card_data.play(targets, hero_stats)
	queue_free()

func _on_drop_point_detector_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func _on_drop_point_detector_area_exited(area: Area2D) -> void:
	targets.erase(area)

func _on_card_drag_or_aiming_started(used_card: Card) -> void:
	if used_card == self:
		return
	disabled = true # Disables all other cards, so we can't interact.

func _on_card_drag_or_aiming_ended(_card: Card) -> void:
	disabled = false
	playable = hero_stats.can_play_card(card_data) # Can't find hero stats? # BUG

func _on_hero_stats_changed() -> void:
	playable = hero_stats.can_play_card(card_data)

func check_playability() -> void:
	playable = hero_stats.can_play_card(card_data)
