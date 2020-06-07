extends Node

func getNavigationInstanceforSelectedCharactor(character : Player) -> Navigation2D:
	var navigationInstance = character.get_node("Navigation2D")
	return navigationInstance

func select_destination(list : Array,pawn:Pawn,goalPosition:Vector2,canHit:bool) -> void:
	for item in list:
		pawn.call_deferred("disableHitBox")
		var navigationInstance : Navigation2D = getNavigationInstanceforSelectedCharactor(PlayerInfo.active_player)
		var path = navigationInstance.get_simple_path(pawn.position, goalPosition)
		var normalizedPath = normalizeNavigationPath(path)
		pawn.navigationPath = normalizedPath
		pawn.garaValue = item
		yield(pawn,"movement_round_complete")
		if(canHit):
			pawn.call_deferred("enableHitBox",true)
	pawn.emit_signal("movement_complete")

func normalizeNavigationPath(path:PoolVector2Array) -> PoolVector2Array:
	var resultArray = PoolVector2Array()
	for point in path:
		var modValueX = floor(point.x / (PlayerInfo.active_player.tile_size))
		var modValueY = floor(point.y / (PlayerInfo.active_player.tile_size))
		var newPoint = Vector2(
			 (modValueX * (PlayerInfo.active_player.tile_size)) + (PlayerInfo.active_player.tile_size / 2.0)
			,(modValueY * (PlayerInfo.active_player.tile_size)) + (PlayerInfo.active_player.tile_size / 2.0))
		
		resultArray.append(newPoint)
	
	return resultArray
