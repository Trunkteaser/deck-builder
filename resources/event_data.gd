extends Resource
class_name EventData

@export var title: String
@export_multiline var text: String
@export var background: Texture2D
@export var art: Texture2D
@export_range(1, 4) var option_count: int = 3
@export_group("Options")
@export_multiline var option_1: String
@export_multiline var option_2: String
@export_multiline var option_3: String
@export_multiline var option_4: String

var hero_stats: HeroStats
# .deck .draftable_cards .max_mana .max_health .health .art
var run_stats: RunStats
# .inspiration
var mantra_handler: MantraHandler
# .add_mantra(mantra)
var mantra_pile: MantraPile
# .mantras.pick_random()       
# Can check can_appear_as_reward(hero_stats) in Mantra

func option_1_chosen() -> void:
	print("Option 1 chosen.")
	Events.event_exited.emit()
	
func option_2_chosen() -> void:
	print("Option 2 chosen.")
	Events.event_exited.emit()
	
func option_3_chosen() -> void:
	print("Option 3 chosen.")
	Events.event_exited.emit()
	
func option_4_chosen() -> void:
	print("Option 4 chosen.")
	Events.event_exited.emit()
