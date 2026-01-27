extends HBoxContainer
class_name MantraHandler

signal mantras_activated(type: Mantra.Type)

const MANTRA_APPLY_INTERVAL := 0.5
const MANTRA_UI = preload("uid://pachqhgau2gn")

#func _ready() -> void:
	#add_mantra(preload("uid://ck6jh0585ob6a"))
	#await get_tree().create_timer(2).timeout
	#add_mantra(preload("uid://de85tcg14gxi4"))
	#await get_tree().create_timer(2).timeout
	#add_mantra(preload("uid://ck6jh0585ob6a"))

func activate_mantras_by_type(type: Mantra.Type) -> void:
	if type == Mantra.Type.EVENT_BASED:
		return
	var mantra_queue: Array[MantraUI] = _get_all_mantra_ui_nodes().filter(
		func(mantra_ui: MantraUI):
			return mantra_ui.mantra.type == type)
	if mantra_queue.is_empty():
		mantras_activated.emit(type)
		return
	var tween := create_tween()
	for mantra_ui: MantraUI in mantra_queue:
		tween.tween_callback(mantra_ui.mantra.activate_mantra.bind(mantra_ui))
		tween.tween_interval(MANTRA_APPLY_INTERVAL)
	tween.finished.connect(func(): mantras_activated.emit(type))

func add_mantras(mantras_array: Array[Mantra]) -> void:
	for mantra: Mantra in mantras_array:
		add_mantra(mantra)
		# Can be used for loading a game with many mantras.

func add_mantra(mantra: Mantra) -> void:
	if has_mantra(mantra.name):
		return
	var new_mantra_ui: MantraUI = MANTRA_UI.instantiate()
	add_child(new_mantra_ui)
	new_mantra_ui.mantra = mantra
	new_mantra_ui.mantra.initialize_mantra(new_mantra_ui)
	new_mantra_ui.tooltip_text = mantra.get_tooltip()

func has_mantra(mantra_name: String) -> bool:
	for mantra_ui: MantraUI in get_children():
		if mantra_ui.mantra.name == mantra_name and is_instance_valid(mantra_ui):
			return true
	return false

func get_all_mantras() -> Array[Mantra]:
	var mantra_ui_nodes := _get_all_mantra_ui_nodes()
	var mantras_array: Array[Mantra] = []
	for mantra_ui: MantraUI in mantra_ui_nodes:
		mantras_array.append(mantra_ui.mantra)
	return mantras_array

func _get_all_mantra_ui_nodes() -> Array[MantraUI]:
	var all_mantra_nodes: Array[MantraUI] = []
	for mantra_ui: MantraUI in get_children():
		all_mantra_nodes.append(mantra_ui)
	return all_mantra_nodes

func _on_child_exiting_tree(mantra_ui: MantraUI) -> void:
	if not mantra_ui:
		return
	if mantra_ui.mantra:
		mantra_ui.mantra.deactivate_mantra(mantra_ui)
