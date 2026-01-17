extends CardState
class_name CardDraggingState

const DRAG_MINIMUM_THRESHOLD := 0.05
var minimum_drag_time_elapsed := false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card.reparent(ui_layer) # No longer attached to hand.
		card.rotation_degrees = 0
	card.visuals.panel.set("theme_override_styles/panel", card.DRAG_STYLE)
	Events.card_drag_started.emit(card)
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)

func exit() -> void:
	Events.card_drag_ended.emit(card)

func on_input(event: InputEvent) -> void:
	var single_targeted := card.card_data.is_single_targeted()
	var mouse_motion := event is InputEventMouseMotion
	var cancel := event.is_action_pressed("right_mouse")
	var confirm := event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if single_targeted and mouse_motion and card.targets.size() > 0: # If size > 0, it has entered the play area.
		state_transition_requested.emit(self, CardState.State.AIMING)
		return
	
	if mouse_motion:
		card.global_position = card.get_global_mouse_position() - card.pivot_offset
	
	if cancel:
		state_transition_requested.emit(self, CardState.State.BASE)
	elif confirm and minimum_drag_time_elapsed:
		get_viewport().set_input_as_handled() # Prevents instantly picking up a new card?
		state_transition_requested.emit(self, CardState.State.RELEASED)
