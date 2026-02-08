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

func get_option_1_description() -> String:
	return option_1

func get_option_2_description() -> String:
	return option_2

func get_option_3_description() -> String:
	return option_3

func get_option_4_description() -> String:
	return option_4
