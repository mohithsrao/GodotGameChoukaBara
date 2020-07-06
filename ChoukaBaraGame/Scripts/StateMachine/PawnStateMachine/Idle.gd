extends IState

func update(_delta):
	if (PlayerInfo.active_player && PlayerInfo.active_player.selectedPawn && PlayerInfo.active_player.selectedPawn.get_instance_id() == owner.get_instance_id()):
		if(not owner.navigationPath.empty()):
			emit_signal("finished", "move")
	if (owner.pawnHit):
			emit_signal("finished", "hit")
