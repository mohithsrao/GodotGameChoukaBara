extends Node2D

var selectedPlayer:Player
var tile_size : = 192

onready var playerSpawnerOneInstance : = $TurnManager/PlayerSpawnerOne
onready var playerSpawnerTwoInstance : = $TurnManager/PlayerSpawnerTwo
onready var playerSpawnerThreeInstance : = $TurnManager/PlayerSpawnerThree
onready var playerSpawnerFourInstance : = $TurnManager/PlayerSpawnerFour
onready var turnManager: = $TurnManager
onready var line : Line2D = $Line2D

func _ready() -> void:
	var playerSelectedError = turnManager.connect("player_selected",self,"_on_player_selected")
	if playerSelectedError:
		print("player_selected failed in Game.gd -> _ready()")
	var playerUnselectedError =turnManager.connect("player_unselected",self,"_on_player_unselected")
	if playerUnselectedError:
		print("player_unselected failed in Game.gd -> _ready()")
	turnManager.Initilize()

func _unhandled_input(event : InputEvent) -> void:
	if selectedPlayer != null:
		if event is InputEventMouseButton and selectedPlayer.selectedPawn != null:
			var inpEvent : InputEventMouseButton = event as InputEventMouseButton
			if inpEvent.button_index == BUTTON_LEFT and inpEvent.pressed:
				var navigationInstance = getNavigationInstanceforSelectedCharactor(selectedPlayer.selectedPawn)
				var path = navigationInstance.get_simple_path(selectedPlayer.selectedPawn.position, inpEvent.position)
				var normalizedPath = normalizeNavigationPath(path)
				selectedPlayer.selectedPawn.navigationPath = normalizedPath
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

func _on_player_selected(player: Player) -> void:
	selectedPlayer = player

func _on_player_unselected() -> void:
	selectedPlayer = null
