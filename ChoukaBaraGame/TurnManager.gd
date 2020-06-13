extends YSort

class_name TurnManager

var goalPosition : Vector2 = Vector2(480,480)
var turnNotifyPopup = preload("res://Scenes/Notification/TurnInfoPopup.tscn")

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
	yield(GameUtility.RollKoude(),"completed")
	yield(startPawnMovement(),"completed")	
	selectNextPlayer()

func startPawnMovement()->void:
	while !PlayerInfo.garaList.empty():
		yield(PlayerInfo.active_player,"pawnSelected")
		PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox",true)
		yield(GameUtility.select_destination(PlayerInfo.garaList.pop_front(),PlayerInfo.active_player.selectedPawn,goalPosition,true),"completed")		
		yield(GameUtility.checkPlayerHit(),"completed")
		if(PlayerInfo.active_player.selectedPawn):
			PlayerInfo.active_player.selectedPawn.resetAnimation()
			PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox",false)	
			PlayerInfo.active_player.selectedPawn.unselect_pawn()

func selectNextPlayer() -> void:
	var next_battler_index: int = (PlayerInfo.active_player.get_index() + 1) % get_child_count()
	PlayerInfo.active_player = get_child(next_battler_index)

