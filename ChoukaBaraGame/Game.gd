extends Node2D

onready var turnManager: = $TurnManager
onready var line : Line2D = $Line2D


func _ready():
	while true:
		turnManager.play_turn()
		yield(turnManager,"turn_complete")
		line.clear_points()

