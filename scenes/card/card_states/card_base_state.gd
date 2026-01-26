extends CardState
class_name CardBaseState

func enter() -> void:
	# Since this is the initial state...
	if not card.is_node_ready():
		await card.ready
	
	if card.tween and card.tween.is_running():
		card.tween.kill()
	
	card.visuals.panel.set("theme_override_styles/panel", card.BASE_STYLE)
	card.reparent_requested.emit(card)
	# When dragging, pivot offset must change.
	# In base state (hand), I want it in the middle to work with fanning.
	card.pivot_offset = Vector2(37, 53)
	
	if card.get_parent() and card.get_parent() is Hand:
		card.get_parent().update_card_fanning()

func on_gui_input(event: InputEvent) -> void:
	if not card.playable or card.disabled:
		return
	
	if event.is_action_pressed("left_mouse"):
		# When dragging, pivot offset must change.
		card.pivot_offset = card.get_global_mouse_position() - card.global_position
		state_transition_requested.emit(self, CardState.State.CLICKED)

func on_mouse_entered() -> void:
	if not card.playable or card.disabled:
		return
	
	card.visuals.panel.set("theme_override_styles/panel", card.HOVER_STYLE)
	card.update_description()

func on_mouse_exited() -> void:
	if not card.playable or card.disabled:
		return
	
	card.visuals.panel.set("theme_override_styles/panel", card.BASE_STYLE)
