extends Node2D
class_name Battle

@export var hero_stats: HeroStats
@export var music: AudioStream
@export var battle_stats: BattleStats

@onready var hand: Hand = %Hand
@onready var battle_ui: CanvasLayer = $BattleUI
@onready var hero_handler: HeroHandler = $HeroHandler
@onready var enemy_handler: EnemyHandler = $EnemyHandler
@onready var hero: Hero = $Hero

func _ready() -> void:
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	Events.player_turn_ended.connect(hero_handler.end_turn) # Why is battle connecting these?
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	Events.player_died.connect(_on_player_died)

func start_battle() -> void:
	MusicPlayer.play(music, true)
	battle_ui.hero_stats = hero_stats
	hero.stats = hero_stats
	enemy_handler.setup_enemies(battle_stats)
	enemy_handler.reset_enemy_actions()
	hero_handler.start_battle(hero_stats)
	battle_ui.initialize_card_pile_ui()

func _on_discard_card_button_pressed() -> void:
	print("in use?")
	hand.discard()

func _on_enemy_turn_ended() -> void:
	hero_handler.start_turn()
	enemy_handler.reset_enemy_actions()

func _on_enemy_handler_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		Events.battle_won.emit()

func _on_player_died() -> void:
	print("You died...")
	get_tree().quit()
