extends YSort

class_name TurnManager

signal turn_notification_complete
signal turn_complete
signal koude_roll_complete

var goalPosition : Vector2 = Vector2(480,480)
var koudePopup = preload("res://Scenes/Gara/GaraPopup.tscn")
var turnNotifyPopup = preload("res://Scenes/Notification/TurnInfoPopup.tscn")
var garaList : Array = []
var popupInstance: AcceptDialog
var turnNotificationPopupInstance: AcceptDialog

func _ready():
	var players = get_children()
	players.sort_custom(self,'sortPlayers')
	for player in players:
		player.raise()
	PlayerInfo.active_player = get_child(0)

func sortPlayers(playerOne:Player,playerTwo:Player) -> bool:
	return playerOne.player_index < playerTwo.player_index

func play_turn() -> void:
	notifyCurrentPlayer()
	yield(self,"turn_notification_complete")
	RollKoude()
	yield(self,"koude_roll_complete")
	yield(startPawnMovement(),"completed")
	selectNextPlayer()
	emit_signal("turn_complete")

func startPawnMovement()->void:
	for value in garaList:
		yield(PlayerInfo.active_player,"pawnSelected")
		PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox",true)
		yield(GameUtility.select_destination(value,PlayerInfo.active_player.selectedPawn,goalPosition,true),"completed")
		PlayerInfo.active_player.selectedPawn.resetAnimation()
		PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox",false)	
		PlayerInfo.active_player.selectedPawn.unselect_pawn()
	garaList.clear()

func notifyCurrentPlayer() -> void:
	turnNotificationPopupInstance = turnNotifyPopup.instance()
	turnNotificationPopupInstance.connect("confirmed",self,"_on_turnNotify_confirmed")
	add_child(turnNotificationPopupInstance)
	turnNotificationPopupInstance.popup_centered()
	turnNotificationPopupInstance.Initialize(PlayerInfo.active_player)
	
func _on_turnNotify_confirmed() -> void:
	turnNotificationPopupInstance.queue_free()
	emit_signal("turn_notification_complete")

func selectNextPlayer() -> void:
	var next_battler_index: int = (PlayerInfo.active_player.get_index() + 1) % get_child_count()
	PlayerInfo.active_player = get_child(next_battler_index)

func RollKoude() -> void:
	popupInstance = koudePopup.instance()
	popupInstance.connect("confirmed",self,"_on_popup_confirmed")
	popupInstance.connect("gara_completed",self,"_on_popup_gara_complete")
	add_child(popupInstance)

func _on_popup_confirmed() -> void:
	popupInstance.queue_free()
	emit_signal("koude_roll_complete")
	
func _on_popup_gara_complete(list:Array):
	for item in list:
		garaList.append(item)
