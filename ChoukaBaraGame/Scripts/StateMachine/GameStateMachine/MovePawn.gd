extends IState

func enter(logic_root):
	.enter(logic_root)
	if(canEnter()):
		yield(GameUtility.select_destination(PlayerInfo.garaList.pop_front(),PlayerInfo.active_player.selectedPawn,true),"completed")		
		yield(get_tree(), "idle_frame")
		
	emit_signal("finished","SelectPawn")

func exit():
	if(PlayerInfo.active_player.selectedPawn):
		PlayerInfo.active_player.selectedPawn.resetAnimation()
		PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox",false)	
		PlayerInfo.active_player.selectedPawn.unselect_pawn()

func canEnter() -> bool:
	var activePlayer = PlayerInfo.active_player
	var canSelectedPawnMoveResult = activePlayer.selectedPawn.canMoveSelectedTurn(PlayerInfo.garaList.front())
	var canPlayerMoveAnyPawnResult = activePlayer.canPlayerMoveAnyPawn(PlayerInfo.garaList)
	if(not PlayerInfo.garaList.empty() && (canSelectedPawnMoveResult as bool)):
		return true
	
	return false
