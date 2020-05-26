extends Node2D

var tile_size : = 192

onready var turnManager: = $TurnManager
onready var line : Line2D = $Line2D

func _unhandled_input(event : InputEvent) -> void:
	if PlayerInfo.active_player != null:
		if event is InputEventMouseButton and PlayerInfo.active_player.selectedPawn != null:
			var inpEvent : InputEventMouseButton = event as InputEventMouseButton
			if inpEvent.button_index == BUTTON_LEFT and inpEvent.pressed:
				var navigationInstance = getNavigationInstanceforSelectedCharactor(PlayerInfo.active_player.selectedPawn)
				var path = navigationInstance.get_simple_path(PlayerInfo.active_player.selectedPawn.position, inpEvent.position)
				var normalizedPath = normalizeNavigationPath(path)
				PlayerInfo.active_player.selectedPawn.navigationPath = normalizedPath
				line.points = normalizedPath

func getNavigationInstanceforSelectedCharactor(character : Pawn) -> Navigation2D:
	var navigationInstance = character.get_node("../Navigation2D")
	return navigationInstance


func normalizeNavigationPath(path:PoolVector2Array) -> PoolVector2Array:
	var resultArray = PoolVector2Array()
	for point in path:
		var modValueX = floor(point.x / (tile_size))
		var modValueY = floor(point.y / (tile_size))
		var newPoint = Vector2(
			 (modValueX * (tile_size)) + (tile_size / 2.0)
			,(modValueY * (tile_size)) + (tile_size / 2.0))
		
		resultArray.append(newPoint)
	
	return resultArray

func _ready():
	while true:
		turnManager.play_turn()
		yield(turnManager,"turn_complete")

