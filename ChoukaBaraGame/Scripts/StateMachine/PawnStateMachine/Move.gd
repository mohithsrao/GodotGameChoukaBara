extends IState

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

func exit():
	var pawn = logic_root as Pawn
	pawn.garaValue = 0;
	pawn.moveCount = 0;

func update(delta):
	var pawn = logic_root as Pawn
	if pawn.tween.is_active():
		return
	if(not pawn.navigationPath.empty()):
		if(pawn.garaValue != -1 && pawn.moveCount == pawn.garaValue):
			pawn.clearNavigationPath()
			pawn.moveCount = 0
			set_process(false)
			pawn.emit_signal("movement_round_complete")
			emit_signal("finished", "idle")
			return
		var navPoint = pawn.navigationPath[0]
		var distance_to_next_point = pawn.global_position.distance_to(navPoint)
		if(distance_to_next_point <= pawn.tile_size/2.0):
			pawn.removeFirstElementFromNavigationPath()
		else:
			var angleToDestination : = rad2deg(pawn.global_position.angle_to_point(navPoint))
			if(angleToDestination < 45 and angleToDestination >= - 45):
				move("left")
			if(angleToDestination < - 45 and angleToDestination >= - 45 * 3):
				move("down")
			if(angleToDestination < - 45 * 3 or angleToDestination >= 45 * 3):
				move("right")
			if(angleToDestination < 45 * 3 and angleToDestination >= 45):
				move("up")
			pawn.moveCount += 1
	else:
		set_process(false)
		pawn.moveCount = 0
		emit_signal("finished", "idle")

func move(dir : String) -> void:
	var pawn = logic_root as Pawn
	pawn.ray.cast_to = inputs[dir] * pawn.tile_size
	pawn.ray.force_raycast_update()
	if !pawn.ray.is_colliding():
		pawn.animationPlayer.play(dir)
		move_tween(inputs[dir])
	
func move_tween(dirVector : Vector2) -> void:
	var pawn = logic_root as Pawn
	var _dummy0 = pawn.tween.interpolate_property(pawn
					,"position"
					,pawn.position
					,pawn.position + dirVector * pawn.tile_size
					,1.0/pawn.speed
					,Tween.TRANS_LINEAR
					,Tween.EASE_IN_OUT)
	var _dummy1 = pawn.tween.start()



