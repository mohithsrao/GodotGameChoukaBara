extends IState

func update(delta):
	var owner1 = owner
	if(owner.pawnHit):
		var homebasePosition = owner.get_parent().getHomebasePosition()	
		yield(GameUtility.select_destination(-1,owner,homebasePosition,false),"completed")
		owner.pawnHit = false;
		emit_signal("finished", "move")
