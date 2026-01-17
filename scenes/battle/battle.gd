extends Node2D
class_name Battle

@export var hero_stats: HeroStats
@export var music: AudioStream

@onready var hand: Hand = %Hand
@onready var battle_ui: CanvasLayer = $BattleUI
@onready var hero_handler: HeroHandler = $HeroHandler
@onready var enemy_handler: EnemyHandler = $EnemyHandler
@onready var hero: Hero = $Hero

func _ready() -> void:
	# TODO Do this on a "run" basis instead.
	var new_stats: HeroStats = hero_stats.create_instance()
	battle_ui.hero_stats = new_stats
	hero.stats = new_stats
	
	Events.enemy_turn_ended.connect(_on_enemy_turn_ended)
	
	Events.player_turn_ended.connect(hero_handler.end_turn) # Why is battle connecting these?
	Events.player_hand_discarded.connect(enemy_handler.start_turn)
	Events.player_died.connect(_on_player_died)
	
	start_battle(new_stats)
	battle_ui.initialize_card_pile_ui()
	
func start_battle(stats: HeroStats) -> void:
	MusicPlayer.play(music, true)
	enemy_handler.reset_enemy_actions()
	hero_handler.start_battle(stats)


func _on_discard_card_button_pressed() -> void:
	print("in use?")
	hand.discard()

func _on_enemy_turn_ended() -> void:
	hero_handler.start_turn()
	enemy_handler.reset_enemy_actions()

func _on_enemy_handler_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		print("Victory!")
		Events.battle_won.emit()

func _on_player_died() -> void:
	print("You died...")
