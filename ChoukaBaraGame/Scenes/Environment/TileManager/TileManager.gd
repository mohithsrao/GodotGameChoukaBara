tool
extends Node
class_name TileManager

export(Resource) var game_board:Resource

var editor_validation_strings:EditorValidationStringConstants = EditorValidationStringConstants.new()
var tile:PackedScene = preload("res://Scenes/Environment/Tile/Tile.tscn")
var home_tile:PackedScene = preload("res://Scenes/Environment/Tile/HomeTile.tscn")
var goal_tile:PackedScene = preload("res://Scenes/Environment/Tile/GoalTile.tscn")

#Region tool
func _get_configuration_warning() -> String:
	var gameBoard = game_board as GameBoard
	if not gameBoard:
		return editor_validation_strings.ResourceRequiredValidationString.format({"variable":"game_board","type":"GameBoard"})
	return ""
#EndRegion

func _ready() -> void:
	var gameBoard = game_board as GameBoard
	assert(gameBoard is GameBoard)
	var tileSize = gameBoard.TileSize.x * 2
	var offset = gameBoard.TileSize.x
	for row in gameBoard.BoardDimension:
		for column in gameBoard.BoardDimension:
			var tile_instance:Tile
			if gameBoard.HomeBaseCountOuterCircle.values().has(Vector2(column,row)):
				tile_instance = home_tile.instance()
				tile_instance.name = "Base_{i}_{j}".format({"i":column,"j":row})
			elif Vector2(column,row) == gameBoard.Goal:
				tile_instance = goal_tile.instance()
				tile_instance.name = "Goal_{i}_{j}".format({"i":column,"j":row})
			else:
				tile_instance = tile.instance()
				tile_instance.name = "{i}_{j}".format({"i":column,"j":row})
			tile_instance.position = Vector2((column*tileSize) + offset,(row*tileSize) + offset)
			tile_instance.game_board = game_board
			add_child(tile_instance)
