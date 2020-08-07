extends Node

var goalPosition : Vector2 = Vector2(480,480)
var Group_Player = "gp_player"

func getNavigationInstanceforSelectedCharactor(character : Player) -> Navigation2D:
	var navigationInstance = character.get_node("Navigation2D")
	return navigationInstance

func select_destination(value : int,pawn:Pawn,canHit:bool,destination:Vector2 = goalPosition) -> void:
	pawn.call_deferred("disableHitBox")
	var navigationInstance : Navigation2D = getNavigationInstanceforSelectedCharactor(PlayerInfo.active_player)
	var path = navigationInstance.get_simple_path(pawn.position, destination)
	var normalizedPath = normalizeNavigationPath(path)
	pawn.navigationPath = normalizedPath
	pawn.garaValue = value
	yield(get_tree(), "idle_frame")
	if(canHit):
		yield(pawn,"movement_round_complete")		
		pawn.call_deferred("enableHitBox",true)

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
