extends IState

func enter(owner):
	.enter(owner)
	if(owner.pawnHit):
		owner.pawnHit = false;
		var homebasePosition = owner.get_parent().getHomebasePosition()	
		yield(GameUtility.select_destination(-1,owner,homebasePosition,false),"completed")
		emit_signal("finished", "move")
