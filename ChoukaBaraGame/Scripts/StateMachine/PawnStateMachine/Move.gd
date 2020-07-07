extends IState

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

func exit():
	owner.garaValue = 0;
	owner.moveCount = 0;

func update(delta):
	if owner.tween.is_active():
		return
	if(not owner.navigationPath.empty()):
		if(owner.garaValue != -1 && owner.moveCount == owner.garaValue):
			owner.clearNavigationPath()
			owner.moveCount = 0
			set_process(false)
			owner.emit_signal("movement_round_complete")
			emit_signal("finished", "idle")
			return
		var navPoint = owner.navigationPath[0]
		var distance_to_next_point = owner.global_position.distance_to(navPoint)
		if(distance_to_next_point <= owner.tile_size/2.0):
			owner.removeFirstElementFromNavigationPath()
		else:
			var angleToDestination : = rad2deg(owner.global_position.angle_to_point(navPoint))
			if(angleToDestination < 45 and angleToDestination >= - 45):
				move("left")
			if(angleToDestination < - 45 and angleToDestination >= - 45 * 3):
				move("down")
			if(angleToDestination < - 45 * 3 or angleToDestination >= 45 * 3):
				move("right")
			if(angleToDestination < 45 * 3 and angleToDestination >= 45):
				move("up")
			owner.moveCount += 1
	else:
		set_process(false)
		owner.moveCount = 0
		emit_signal("finished", "idle")

func move(dir : String) -> void:
	owner.ray.cast_to = inputs[dir] * owner.tile_size
	owner.ray.force_raycast_update()
	if !owner.ray.is_colliding():
		owner.animationPlayer.play(dir)
		move_tween(inputs[dir])
	
func move_tween(dirVector : Vector2) -> void:
	var _dummy0 = owner.tween.interpolate_property(owner
					,"position"
					,owner.position
					,owner.position + dirVector * owner.tile_size
					,1.0/owner.speed
					,Tween.TRANS_LINEAR
					,Tween.EASE_IN_OUT)
	var _dummy1 = owner.tween.start()



