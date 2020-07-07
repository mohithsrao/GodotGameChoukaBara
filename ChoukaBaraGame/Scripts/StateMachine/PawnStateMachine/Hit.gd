extends IState

func enter(owner):
	.enter(owner)
	if(owner.pawnHit):
		owner.pawnHit = false;
		var homebasePosition = owner.get_parent().getHomebasePosition()	
		yield(GameUtility.select_destination(-1,owner,false,homebasePosition),"completed")
		emit_signal("finished", "move")
