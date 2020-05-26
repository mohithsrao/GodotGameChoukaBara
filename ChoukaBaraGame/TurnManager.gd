extends YSort

class_name TurnManager

signal turn_complete

func _ready():
	var players = get_children()
	players.sort_custom(self,'sortPlayers')
	for player in players:
		player.raise()
	PlayerInfo.active_player = get_child(0)

func sortPlayers(playerOne:Player,playerTwo:Player) -> bool:
	return playerOne.player_index > playerTwo.player_index
		
func move_pawn():
	if PlayerInfo.active_player.selectedPawn.tween.is_active():
			return
#	while (not PlayerInfo.active_player.selectedPawn.navigationPath.empty()):
	for navPoint in PlayerInfo.active_player.selectedPawn.navigationPath:
		var distance_to_next_point = PlayerInfo.active_player.selectedPawn.global_position.distance_to(navPoint)
		if(distance_to_next_point <= PlayerInfo.active_player.selectedPawn.tile_size/2.0):
			#PlayerInfo.active_player.selectedPawn.navigationPath.remove(0)
			pass	
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
		
	PlayerInfo.active_player.selectedPawn.unselect_pawn()
	selectNextPlayer()
	emit_signal("movement_complete")

func play_turn():
	yield(PlayerInfo.active_player,"pawnSelected")
	yield(PlayerInfo.active_player.selectedPawn,"destination_selected")
	yield(self.move_pawn(),"movement_complete")
	emit_signal("turn_complete")

func selectNextPlayer():
	var next_battler_index: int = (PlayerInfo.active_player.get_index() + 1) % get_child_count()
	PlayerInfo.active_player = get_child(next_battler_index)
