extends CardState
class_name CardReleasedState

var played: bool

func enter() -> void:
	played = false
	
	if not card.targets.is_empty(): # We have a valid target!
		played = true
		card.play()

func on_input(_event: InputEvent) -> void:
	if played:
		return
	
	# If we receive and input and the card isn't played, it was the cancelling input.
	state_transition_requested.emit(self, CardState.State.BASE)
	
