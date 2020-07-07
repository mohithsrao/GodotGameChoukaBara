extends IStateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	states_map = {
		"SelectNextPlayer": $SelectNextPlayer,
		"CalculateGara": $CalculateGara,
		"SelectPawn": $SelectPawn,
		"MovePawn": $MovePawn
	}

func _change_state(state_name):
	"""
	The base state_machine interface this node extends does most of the work
	"""
	if not _active:
		return
	if state_name in ["CalculateGara", "SelectPawn","MovePawn"]:
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)

func _input(event):
	"""
	Here we only handle input that can interrupt states,
	otherwise we let the state node handle it
	"""
	current_state.handle_input(event)
