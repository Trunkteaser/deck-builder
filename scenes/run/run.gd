extends Node
class_name Run

const BATTLE_SCENE := preload("uid://0qyqwumjfu4w")
const BATTLE_REWARD_SCENE := preload("uid://dbw806mdi7k6i")
const CAMPFIRE_SCENE := preload("uid://b5td37dfj5iau")
const MAP_SCENE := preload("uid://bm215cpa3pkhe")
const SHOP_SCENE := preload("uid://cha87b6ju17jw")
const TREASURE_SCENE := preload("uid://djbb0v375o0fq")

@export var run_startup: RunStartup

@onready var current_view: Node = $CurrentView
@onready var map_button: Button = %MapButton
@onready var battle_button: Button = %BattleButton
@onready var shop_button: Button = %ShopButton
@onready var treasure_button: Button = %TreasureButton
@onready var rewards_button: Button = %RewardsButton
@onready var campfire_button: Button = %CampfireButton

var hero: HeroStats

func _ready() -> void:
	if not run_startup:
		return
	match run_startup.type:
		RunStartup.Type.NEW_RUN:
			hero = run_startup.picked_hero.create_instance()
			_start_run()
		RunStartup.Type.CONTINUED_RUN:
			# TODO Implement loading.
			pass

func _start_run() -> void:
	_setup_event_connections()
	# TODO Generate map.

func _change_view(scene: PackedScene) -> void:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	#get_tree().paused = false # In case BattleOver screen or other has paused.
	var new_view := scene.instantiate()
	current_view.add_child(new_view)

func _setup_event_connections() -> void:
	Events.battle_won.connect(_change_view.bind(BATTLE_REWARD_SCENE))
	Events.battle_reward_exited.connect(_change_view.bind(MAP_SCENE))
	Events.campfire_exited.connect(_change_view.bind(MAP_SCENE))
	Events.map_exited.connect(_on_map_exited)
	Events.shop_exited.connect(_change_view.bind(MAP_SCENE))
	Events.treasure_room_exited.connect(_change_view.bind(MAP_SCENE))
	# Debug button setup below.
	battle_button.pressed.connect(_change_view.bind(BATTLE_SCENE))
	campfire_button.pressed.connect(_change_view.bind(CAMPFIRE_SCENE))
	map_button.pressed.connect(_change_view.bind(MAP_SCENE))
	rewards_button.pressed.connect(_change_view.bind(BATTLE_REWARD_SCENE))
	shop_button.pressed.connect(_change_view.bind(SHOP_SCENE))
	treasure_button.pressed.connect(_change_view.bind(TREASURE_SCENE))

func _on_map_exited() -> void:
	# TODO Change view based on room type.
	pass
