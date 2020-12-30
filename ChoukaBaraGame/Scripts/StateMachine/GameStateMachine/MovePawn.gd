extends IState

func enter(logic_root):
	.enter(logic_root)
	var canMoveResult = PlayerInfo.active_player.selectedPawn.canMoveSelectedTurn(PlayerInfo.garaList.front())
	if(not PlayerInfo.garaList.empty() && (canMoveResult as bool)):
		yield(GameUtility.select_destination(PlayerInfo.garaList.pop_front(),PlayerInfo.active_player.selectedPawn,true),"completed")		
		yield(get_tree(), "idle_frame")
#	else:
#		Update HUD to display error for not able to enter Inner Circle
		
	emit_signal("finished","SelectPawn")

func exit():
	if(PlayerInfo.active_player.selectedPawn):
		PlayerInfo.active_player.selectedPawn.resetAnimation()
		PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox",false)	
		PlayerInfo.active_player.selectedPawn.unselect_pawn()
