extends Resource
class_name EventData

@export var title: String
@export_multiline var text: String
@export var art: Texture2D
@export_range(1, 4) var option_count: int = 3
@export_group("Options")
@export_multiline var option_1: String
@export_multiline var option_2: String
@export_multiline var option_3: String
@export_multiline var option_4: String

var hero_stats: HeroStats
# .deck .draftable_cards .max_mana .max_health .health .art

# Need access to stats (health, card rewards)
# Deck, inspiration, mantrahandler and mantra list, needs to be able to start battle.

func option_1_chosen() -> void:
	print("Option 1 chosen.")
	
func option_2_chosen() -> void:
	print("Option 2 chosen.")
	
func option_3_chosen() -> void:
	print("Option 3 chosen.")
	
func option_4_chosen() -> void:
	print("Option 4 chosen.")
