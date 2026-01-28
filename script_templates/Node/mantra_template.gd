extends Mantra

func initialize_mantra(_mantra_ui: MantraUI) -> void:
	print("This happens when mantra is obtained.")
	print("Can connect to signals.")

func activate_mantra(mantra_ui: MantraUI) -> void:
	#var hero := mantra_ui.get_tree().get_nodes_in_group("hero")
	#var enemies := mantra_ui.get_tree().get_nodes_in_group("enemies")
	print("This happens at specific times based on type.")
	mantra_ui.flash()

func deactivate_mantra(_mantra_ui: MantraUI) -> void:
	print("This happens when mantra is lost.")
	print("EventBased should disconnect from signals.")

func get_tooltip() -> String:
	return tooltip
	# Only useful if "magic number".
