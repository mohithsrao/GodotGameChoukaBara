extends IState

func enter(owner):
	.enter(owner)
	if(PlayerInfo.garaList.empty()):
		if(PlayerInfo.active_player && PlayerInfo.active_player.needsReRoll):
			PlayerInfo.active_player.needsReRoll = false
			emit_signal("finished","CalculateGara")
		emit_signal("finished","SelectNextPlayer")
	else:
		yield(PlayerInfo.active_player,"pawnSelected")
		emit_signal("finished","MovePawn")
		PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox",true)

func update(_delta):
	#	When player hits a enemy pawn
	if(PlayerInfo.active_player && PlayerInfo.active_player.needsReRoll):
		emit_signal("finished","CalculateGara")
		PlayerInfo.active_player.needsReRoll = false
