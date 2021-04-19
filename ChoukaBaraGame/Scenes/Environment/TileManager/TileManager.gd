tool
extends Node
class_name TileManager

export(Resource) var game_board:Resource

var editor_validation_strings:EditorValidationStringConstants = EditorValidationStringConstants.new()
var tile:PackedScene = preload("res://Scenes/Environment/Tile/Tile.tscn")
var home_tile:PackedScene = preload("res://Scenes/Environment/Tile/HomeTile.tscn")
var goal_tile:PackedScene = preload("res://Scenes/Environment/Tile/GoalTile.tscn")

#Region tool
func _get_configuration_warning():
	var gameBoard = game_board as GameBoard
	if not gameBoard:
		return editor_validation_strings.ResourceRequiredValidationString.format({"variable":"game_board","type":"GameBoard"})
	return ""
#EndRegion

func _ready():
	var gameBoard = game_board as GameBoard
	assert(gameBoard is GameBoard)
	var offset = gameBoard.TileSize/2
	for j in gameBoard.BoardDimension:
		for i in gameBoard.BoardDimension:
			var tile_instance:Tile
			if gameBoard.HomeBaseCountOuterCircle.values().has(Vector2(i,j)):
				tile_instance = home_tile.instance()
				tile_instance.name = "Base_{i}_{j}".format({"i":i,"j":j})
			elif Vector2(i,j) == gameBoard.Goal:
				tile_instance = goal_tile.instance()
				tile_instance.name = "Goal_{i}_{j}".format({"i":i,"j":j})
			else:
				tile_instance = tile.instance()
				tile_instance.name = "{i}_{j}".format({"i":i,"j":j})
			#tile_instance.position = 
			add_child(tile_instance)
