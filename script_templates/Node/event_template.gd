extends EventData

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
