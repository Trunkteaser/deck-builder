extends EventData

const ALL_MUST_FEAR_ME = preload("uid://ci6mgf0ys0du4")
const MITE_CARD = preload("uid://eynjiijuxrvr")
const MITE_SFX = preload("uid://dodahfs7ua4ev")

func option_1_chosen() -> void:
	mantra_handler.add_mantra(ALL_MUST_FEAR_ME)
	Events.event_exited.emit()
	
func option_2_chosen() -> void:
	run_stats.inspiration += 200
	Events.event_exited.emit()
	
func option_3_chosen() -> void:
	for i in 3:
		hero_stats.deck.add_card(MITE_CARD)
		SFXPlayer.play(MITE_SFX)
		await mantra_handler.get_tree().create_timer(0.2).timeout
	Events.event_exited.emit()
	
