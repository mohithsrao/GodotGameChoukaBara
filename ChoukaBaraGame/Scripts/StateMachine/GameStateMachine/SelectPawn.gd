extends IState

func enter(logic_root):
	.enter(logic_root)
#	when player finishes the turn or cannot move any pawn  
	if(PlayerInfo.garaList.empty()):
		yield(get_tree().create_timer(0.5),"timeout")
		PlayerInfo.active_player.SetZIndex(false)
		if(PlayerInfo.active_player && PlayerInfo.active_player.needsReRoll):
			PlayerInfo.active_player.needsReRoll = false
			emit_signal("finished","CalculateGara")
		else:
			emit_signal("finished","SelectNextPlayer")
	else:
		PlayerInfo.active_player.SetZIndex(true)
		yield(PlayerInfo.active_player,"pawnSelected")
		PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox",true)
		emit_signal("finished","MovePawn")
