extends Control
class_name BattleRewards

const CARD_REWARDS = preload("uid://xivd0tm3vqwy")
const REWARD_BUTTON = preload("uid://yu10wywl2s4m")
const INSPIRATION_ICON := preload("uid://bpfavoc513j3m")
const INSPIRATION_TEXT := "%s inspiration"
const CARD_ICON := preload("uid://dblwri7jh6k0v")
const CARD_TEXT := "add new card"
# TODO Relics here as well later.

@export var run_stats: RunStats # Provided by Run.
@export var hero_stats: HeroStats # Provided by Run.

@onready var rewards: VBoxContainer = %Rewards

var card_reward_total_weight := 0.0
var card_rarity_weights := {
	CardData.Rarity.ORDINARY: 0.0,
	CardData.Rarity.REMARKABLE: 0.0,
	CardData.Rarity.VISIONARY: 0.0}

func _ready() -> void:
	for reward: RewardButton in rewards.get_children():
		reward.queue_free()
	Events.card_reward_selected.connect(_on_card_reward_taken)

func add_inspiration_reward(amount: int) -> void:
	var inspiration_reward: RewardButton = REWARD_BUTTON.instantiate()
	inspiration_reward.reward_icon = INSPIRATION_ICON
	inspiration_reward.reward_text = INSPIRATION_TEXT % amount
	inspiration_reward.pressed.connect(_on_inspiration_reward_taken.bind(amount))
	if rewards: # Idk bro got crashes.
		rewards.add_child.call_deferred(inspiration_reward)

func add_card_reward() -> void:
	var card_reward: RewardButton = REWARD_BUTTON.instantiate()
	card_reward.reward_icon = CARD_ICON
	card_reward.reward_text = CARD_TEXT
	card_reward.pressed.connect(_show_card_rewards)
	if rewards: # Idk bro got crashes.
		rewards.add_child.call_deferred(card_reward)

func _show_card_rewards() -> void:
	if not run_stats or not hero_stats:
		return
	var card_rewards: CardRewards = CARD_REWARDS.instantiate()
	add_child(card_rewards)
	
	var card_reward_array: Array[CardData] = []
	var available_cards: Array[CardData] = hero_stats.draftable_cards.cards.duplicate(true)
	for i in run_stats.card_rewards: # By default 3.
		_setup_card_chances()
		var roll := randf_range(0.0, card_reward_total_weight)
		for rarity: CardData.Rarity in card_rarity_weights:
			if card_rarity_weights[rarity] > roll:
				_modify_weights(rarity)
				var picked_card := _get_random_available_card(available_cards, rarity)
				card_reward_array.append(picked_card)
				available_cards.erase(picked_card)
				break
	card_rewards.rewards = card_reward_array
	card_rewards.show()

func _setup_card_chances() -> void:
	card_reward_total_weight = run_stats.ordinary_weight + run_stats.remarkable_weight + run_stats.visionary_weight
	card_rarity_weights[CardData.Rarity.ORDINARY] = run_stats.ordinary_weight
	card_rarity_weights[CardData.Rarity.REMARKABLE] = run_stats.ordinary_weight + run_stats.remarkable_weight
	card_rarity_weights[CardData.Rarity.VISIONARY] = card_reward_total_weight

func _modify_weights(rarity_rolled: CardData.Rarity) -> void:
	if rarity_rolled == CardData.Rarity.VISIONARY:
		run_stats.visionary_weight = RunStats.BASE_VISIONARY_WEIGHT
	else:
		run_stats.visionary_weight = clampf(run_stats.visionary_weight + 0.3, run_stats.BASE_VISIONARY_WEIGHT, 5.0)

func _get_random_available_card(available_cards: Array[CardData], with_rarity: CardData.Rarity) -> CardData:
	var all_possible_cards := available_cards.filter(
		func(card_data: CardData):
			return card_data.rarity == with_rarity)
	return all_possible_cards.pick_random()

func _on_card_reward_taken(card_data: CardData) -> void:
	if not hero_stats or not card_data: # No deck (!?) or reward was skipped = null.
		return
	hero_stats.deck.add_card(card_data)

func _on_inspiration_reward_taken(amount: int) -> void:
	if not run_stats:
		return
	run_stats.inspiration += amount

func _on_button_pressed() -> void:
	Events.battle_reward_exited.emit()
