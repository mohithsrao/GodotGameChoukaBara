extends IState

func update(_delta):
	#	When player hits a enemy pawn
	if(PlayerInfo.active_player && PlayerInfo.active_player.needsReRoll):
		emit_signal("finished","CalculateGara")
		PlayerInfo.active_player.needsReRoll = false
	elif(PlayerInfo.garaList.empty()):
		emit_signal("finished","SelectNextPlayer")
	else:
		yield(PlayerInfo.active_player,"pawnSelected")
		emit_signal("finished","MovePawn")

func exit():
	PlayerInfo.active_player.selectedPawn.call_deferred("enableHitBox",true)
