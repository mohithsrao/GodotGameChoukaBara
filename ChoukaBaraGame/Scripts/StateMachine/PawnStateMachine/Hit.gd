extends IState

func enter(logic_root):
	.enter(logic_root)
	var pawn = logic_root as Pawn
	if(pawn.pawnHit):
		pawn.pawnHit = false;
		var homebasePosition = pawn.get_parent().getHomebasePosition()	
		yield(GameUtility.select_destination(-1,pawn,false,homebasePosition),"completed")
		pawn.currentLocation = 0
		emit_signal("finished", "move")
