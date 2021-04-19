"""
Tile class is the base class for all different Tiles in game like
1) Home Tile
2) Goal Tile
3) Inner Tile
4) Outer Tile

The Use of this class is to abstract the Tile Feature used in this game

"""
tool
extends Area2D
class_name Tile

signal pawn_entered(pawn)
signal pawn_exited(pawn)

var signalResource:SignalResource = SignalResource.new()
var editor_validation_strings:EditorValidationStringConstants = EditorValidationStringConstants.new()

export(Resource) var game_board:Resource

var residingPawns:Array = []

onready var collision_shape:CollisionShape2D = $CollisionShape2D
func _ready() -> void:
	signalResource.connect_signal("area_entered",self,"_on_tile_area_entered")
	signalResource.connect_signal("area_exited",self,"_on_tile_area_exited")
	var gameBoard = game_board as GameBoard
	assert(gameBoard is GameBoard)
	var collisionShape = collision_shape.shape as RectangleShape2D
	assert(collisionShape is RectangleShape2D)
	collisionShape.extents = gameBoard.TileSize

func _on_tile_area_entered(area:Area2D)-> void:
	var pawn = area as Pawn
	if (pawn):
		residingPawns.append(pawn)
		emit_signal("pawn_entered",pawn)

func _on_tile_area_exited(area:Area2D)-> void:
	var pawn = area as Pawn
	if (pawn):
		residingPawns.erase(pawn)
		emit_signal("pawn_exited",pawn)

func _exit_tree() -> void:
	signalResource.disconnect_signal("area_entered",self,"_on_tile_area_entered")
	signalResource.disconnect_signal("area_exited",self,"_on_tile_area_exited")

#Region tool
func _get_configuration_warning() -> String:
	var gameBoard = game_board as GameBoard
	if not gameBoard:
		return editor_validation_strings.ResourceRequiredValidationString.format({"variable":"game_board","type":"GameBoard"})
	return ""
#EndRegion
