extends CardState
class_name CardAimingState

const MOUSE_Y_SNAPBACK_THRESHOLD := 358 # Out of 360? Right?

func enter() -> void:
	card.targets.clear()
	# Need an offset to display the card in the center of the hand.
	var offset := Vector2(card.parent.size.x/2, -card.size.y/2)
	offset.x -= card.size.x/2
	card.animate_to_position(card.parent.global_position + offset, 0.2)
	card.drop_point_detector.monitoring = false # Don't want to target the card drop area.
	Events.card_aim_started.emit(card)

func exit() -> void:
	Events.card_aim_ended.emit(card)

func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var mouse_at_bottom := card.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD
	
	if (mouse_motion and mouse_at_bottom) or event.is_action_pressed("right_mouse"):
		state_transition_requested.emit(self, CardState.State.BASE)
	elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		get_viewport().set_input_as_handled()
		state_transition_requested.emit(self, CardState.State.RELEASED)
