extends Node2D

onready var turnManager: TurnManager = $TurnManager

func _ready():
	while true:
		turnManager.play_turn()
		yield(turnManager,"turn_complete")


