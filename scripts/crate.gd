extends Node2D

enum state { CLOSED, OPEN }
var current_state = state.OPEN

func switch_state() -> void:
	if current_state == state.OPEN:
		current_state = state.CLOSED
	else:
		current_state = state.OPEN

