extends IState

func update(_delta):
	var pawn = logic_root as Pawn
	if (PlayerInfo.active_player && PlayerInfo.active_player.selectedPawn && PlayerInfo.active_player.selectedPawn.get_instance_id() == pawn.get_instance_id()):
		if(not pawn.navigationPath.empty()):
			emit_signal("finished", "move")
	if (pawn.pawnHit):
			emit_signal("finished", "hit")
