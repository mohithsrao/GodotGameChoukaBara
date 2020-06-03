extends YSort

class_name TurnManager

signal turn_complete
signal movement_complete
signal koude_roll_complete
signal movement_round_complete

var goalPosition : Vector2 = Vector2(480,480)
var koudePopup = preload("res://Scenes/Gara/GaraPopup.tscn")
var garaList : Array
var moveCount:int = 0
var garaValue:int = 0
var popupInstance: AcceptDialog

func _ready():
	var players = get_children()
	players.sort_custom(self,'sortPlayers')
	for player in players:
		player.raise()
	PlayerInfo.active_player = get_child(0)

func sortPlayers(playerOne:Player,playerTwo:Player) -> bool:
	return playerOne.player_index > playerTwo.player_index

func _process(_delta):
	if !PlayerInfo.active_player.selectedPawn:
		return
	if PlayerInfo.active_player.selectedPawn && PlayerInfo.active_player.selectedPawn.tween.is_active():
		return
	if(moveCount == garaValue):
		PlayerInfo.active_player.selectedPawn.clearNavigationPath()
		moveCount = 0
		emit_signal("movement_round_complete")
	if(not PlayerInfo.active_player.selectedPawn.navigationPath.empty()):
		var navPoint = PlayerInfo.active_player.selectedPawn.navigationPath[0]
		var distance_to_next_point = PlayerInfo.active_player.selectedPawn.global_position.distance_to(navPoint)
		if(distance_to_next_point <= PlayerInfo.active_player.selectedPawn.tile_size/2.0):
			PlayerInfo.active_player.selectedPawn.removeFirstElementFromNavigationPath()
		else:
			var angleToDestination : = rad2deg(PlayerInfo.active_player.selectedPawn.global_position.angle_to_point(navPoint))
			if(angleToDestination < 45 and angleToDestination >= - 45):
				PlayerInfo.active_player.selectedPawn.move("left")
			if(angleToDestination < - 45 and angleToDestination >= - 45 * 3):
				PlayerInfo.active_player.selectedPawn.move("down")
			if(angleToDestination < - 45 * 3 or angleToDestination >= 45 * 3):
				PlayerInfo.active_player.selectedPawn.move("right")
			if(angleToDestination < 45 * 3 and angleToDestination >= 45):
				PlayerInfo.active_player.selectedPawn.move("up")
			moveCount += 1
	else:
		moveCount = 0
		emit_signal("movement_complete")

func play_turn() -> void:
	yield(PlayerInfo.active_player,"pawnSelected")
	RollKoude()
	yield(self,"koude_roll_complete")
	select_destination(garaList)	
	yield(self,"movement_complete")
	PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox")
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

func select_destination(list : Array) -> void:
	for item in list:
		PlayerInfo.active_player.selectedPawn.call_deferred("disableHitBox")
		var navigationInstance = getNavigationInstanceforSelectedCharactor(PlayerInfo.active_player)
		var path = navigationInstance.get_simple_path(PlayerInfo.active_player.selectedPawn.position, goalPosition)
		var normalizedPath = normalizeNavigationPath(path)
		garaValue = item
		PlayerInfo.active_player.selectedPawn.navigationPath = normalizedPath
		yield(self,"movement_round_complete")
		PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox")

func getNavigationInstanceforSelectedCharactor(character : Player) -> Navigation2D:
	var navigationInstance = character.get_node("Navigation2D")
	return navigationInstance


func normalizeNavigationPath(path:PoolVector2Array) -> PoolVector2Array:
	var resultArray = PoolVector2Array()
	for point in path:
		var modValueX = floor(point.x / (PlayerInfo.active_player.tile_size))
		var modValueY = floor(point.y / (PlayerInfo.active_player.tile_size))
		var newPoint = Vector2(
			 (modValueX * (PlayerInfo.active_player.tile_size)) + (PlayerInfo.active_player.tile_size / 2.0)
			,(modValueY * (PlayerInfo.active_player.tile_size)) + (PlayerInfo.active_player.tile_size / 2.0))
		
		resultArray.append(newPoint)
	
	return resultArray

func _on_popup_confirmed() -> void:
	popupInstance.queue_free()
	emit_signal("koude_roll_complete")
	
func _on_popup_gara_complete(list:Array):
	garaList = list
