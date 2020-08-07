"""
Base interface for all states: it doesn't do anything in itself
but forces us to pass the right arguments to the methods below
and makes sure every State object had all of these methods.
"""
extends Node
class_name IState

signal finished(next_state_name)

var logic_root

# Initialize the state. E.g. change the animation
func enter(logic_root):
	self.logic_root = logic_root

# Clean up the state. Reinitialize values like a timer
func exit():
	return

func handle_input(event):
	return

func update(delta):
	return

func _on_animation_finished(anim_name):
	return
