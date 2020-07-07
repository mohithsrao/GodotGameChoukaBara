extends IState

func enter(owner):
	.enter(owner)
	if(not PlayerInfo.garaList.empty()):
		yield(GameUtility.select_destination(PlayerInfo.garaList.pop_front(),PlayerInfo.active_player.selectedPawn,true),"completed")		
		yield(get_tree(), "idle_frame")
		emit_signal("finished","SelectPawn")

func exit():
	if(PlayerInfo.active_player.selectedPawn):
		PlayerInfo.active_player.selectedPawn.resetAnimation()
		PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox",false)	
		PlayerInfo.active_player.selectedPawn.unselect_pawn()
