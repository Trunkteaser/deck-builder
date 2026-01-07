extends Node2D
class_name Battle

@export var hero_stats: HeroStats

@onready var hand: Hand = %Hand
@onready var battle_ui: CanvasLayer = $BattleUI
@onready var hero_handler: HeroHandler = $HeroHandler
@onready var hero: Hero = $Hero

func _ready() -> void:
	# TODO Do this on a "run" basis instead.
	var new_stats: HeroStats = hero_stats.create_instance()
	battle_ui.hero_stats = new_stats
	hero.stats = new_stats
	
	Events.player_turn_ended.connect(hero_handler.end_turn) # Why is battle connecting these?
	Events.player_hand_discarded.connect(hero_handler.start_turn)
	
	start_battle(new_stats)
	
func start_battle(stats: HeroStats) -> void:
	hero_handler.start_battle(stats)


#func _on_draw_card_button_pressed() -> void:
	#hand.add_card(hero_stats.draw_pile.draw_card())
	# TODO Change it to debug handling these.


func _on_discard_card_button_pressed() -> void:
	hand.discard()
