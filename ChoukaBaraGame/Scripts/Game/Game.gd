extends Node2D

onready var turnManager: TurnManager = $TurnManager

func _ready():
	while true:
		yield(turnManager.play_turn(),"completed")
