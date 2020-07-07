extends Node2D

onready var goalInstance = $Goal

func _ready():
	goalInstance.position = GameUtility.goalPosition
	goalInstance.connect("area_entered",self,"_on_Goal_Reached")

func _on_Goal_Reached(area:Area2D):
	var pawn = area.get_parent()
	var parent = pawn.get_parent()
	var activePawnsInPlayer = get_tree().get_nodes_in_group(parent.name)
	if(activePawnsInPlayer.size() ==1):
#		Implement Player's game finished
		pass
	var activePlayers = get_tree().get_nodes_in_group(GameUtility.Group_Player)
	if(activePlayers.size() ==1):
#		Implement game over for all players
		pass
	pawn.queue_free()
