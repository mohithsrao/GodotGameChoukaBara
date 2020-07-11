extends Node2D

onready var goalInstance = $Goal
onready var playerNotification = preload("res://Scenes/Notification/TurnInfoPopup.tscn")

func _ready():
	goalInstance.position = GameUtility.goalPosition
	goalInstance.connect("area_entered",self,"_on_Goal_Reached")

func _on_Goal_Reached(area:Area2D):
	var pawn = area.get_parent()
	var parent = pawn.get_parent()
	var activePawnsInPlayer = get_tree().get_nodes_in_group(parent.name)
	if(activePawnsInPlayer.size() == 1):
#		Player's game finished
		var playerNotificationInstance = playerNotification.instance()
		add_child(playerNotificationInstance)
		playerNotificationInstance.Initialize(parent)
		yield(playerNotificationInstance,"confirmed")
		playerNotificationInstance.queue_free()
	var activePlayers = get_tree().get_nodes_in_group(GameUtility.Group_Player)
	if(activePlayers.size() ==1):
#		Game Over for all players - Reloads the scene
		get_tree().reload_current_scene()
	pawn.queue_free()
