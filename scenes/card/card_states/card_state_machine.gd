extends Node
class_name CardStateMachine

@export var initial_state: CardState

var current_state: CardState
var states := {}

func init(card: Card) -> void:
	for child in get_children():
		if child is CardState:
			states[child.state] = child # Key in brackets, value after equal sign.
			child.state_transition_requested.connect(_on_state_transition_requested)
			child.card = card # Passes a reference to the child.
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

#region Passing all input and mouse events to the current state.
func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)

func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)

func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()

func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()
#endregion

func _on_state_transition_requested(from: CardState, to: CardState.State) -> void:
	if from != current_state: 
		return # If we're transitioning from a different state than the current one -> bad.
	
	var new_state: CardState = states[to] # New state declared as the one we transition to.
	if not new_state:
		return # If the state isn't in the dictionary -> bad.
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
