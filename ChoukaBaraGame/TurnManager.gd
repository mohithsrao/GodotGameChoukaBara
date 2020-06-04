extends YSort

class_name TurnManager

signal turn_complete
signal koude_roll_complete

var goalPosition : Vector2 = Vector2(480,480)
var koudePopup = preload("res://Scenes/Gara/GaraPopup.tscn")
var garaList : Array
var popupInstance: AcceptDialog

func _ready():
	var players = get_children()
	players.sort_custom(self,'sortPlayers')
	for player in players:
		player.raise()
	PlayerInfo.active_player = get_child(0)

func sortPlayers(playerOne:Player,playerTwo:Player) -> bool:
	return playerOne.player_index < playerTwo.player_index

func play_turn() -> void:
	yield(PlayerInfo.active_player,"pawnSelected")
	RollKoude()
	yield(self,"koude_roll_complete")
	GameUtility.select_destination(garaList,PlayerInfo.active_player.selectedPawn,goalPosition,true)	
	yield(PlayerInfo.active_player.selectedPawn,"movement_complete")
	PlayerInfo.active_player.selectedPawn.enableHitBox(false)
	
	PlayerInfo.active_player.selectedPawn.unselect_pawn()
	selectNextPlayer()
	emit_signal("turn_complete")

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
	garaList = list
