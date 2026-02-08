extends EventData

func option_1_chosen() -> void:
	run_stats.inspiration += 100
	Events.event_exited.emit()
	
func option_2_chosen() -> void:
	Events.event_exited.emit()
