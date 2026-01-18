extends ColorRect
class_name CardRewards

#signal card_reward_selected(card_data: CardData)

const CARD_REWARD_SCENE = preload("uid://dshlk5gudostl")

@export var rewards: Array[CardData] : set = set_rewards # Set by BattleRewards.

@onready var cards: HBoxContainer = %Cards
@onready var skip_reward_button: Button = %SkipRewardButton

func _ready() -> void:
	_clear_rewards()
	
	Events.card_reward_selected.connect(_on_card_reward_selected)
	
	skip_reward_button.pressed.connect(
		func():
			Events.card_reward_selected.emit(null)
			queue_free())

func _clear_rewards() -> void:
	for card_reward: CardReward in cards.get_children():
		card_reward.queue_free()

func set_rewards(new_cards: Array[CardData]) -> void:
	rewards = new_cards
	if not is_node_ready():
		await ready
	_clear_rewards()
	for card_data: CardData in rewards:
		var new_card: CardReward = CARD_REWARD_SCENE.instantiate()
		cards.add_child(new_card)
		new_card.card_data = card_data
		#new_card.card_reward_selected.connect(_on_card_reward_selected)

func _on_card_reward_selected(_card_data: CardData):
	queue_free()
