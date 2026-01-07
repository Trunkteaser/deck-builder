extends CardState
class_name CardClickedState

func enter() -> void:
	card.drop_point_detector.monitoring = true

func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		state_transition_requested.emit(self, CardState.State.DRAGGING)
