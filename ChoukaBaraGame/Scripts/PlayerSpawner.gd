extends Node

class_name Player

signal pawnSelected

export var speed = 2
export var tile_size = 192
export(int,"One","Two","three","Four") var player_index = 0

var playerScene = preload("res://Scenes/Player/Player.tscn")
var maxCharactersPerPlayer = 4

var selectedPawn : Pawn setget selectedPawn_set, selectedPawn_get
func selectedPawn_set(value) -> void:
	selectedPawn = value
	emit_signal("pawnSelected")

func selectedPawn_get() -> Pawn:
	return selectedPawn

# Called when the node enters the scene tree for the first time.
func _ready():
	for playerIndex in range(0,maxCharactersPerPlayer):
		var character = playerScene.instance()
		(character.get_node("Sprite") as Sprite).texture = PlayerInfo.playerDetails[player_index].texture
		character.name =  "Player_" + str(player_index) + "_" + str(playerIndex)
		character.initialSetup(speed,tile_size,playerIndex)
		character.position = character.position.snapped(Vector2.ONE * tile_size)
		character.position.y = tile_size * PlayerInfo.playerDetails[player_index].y_offset
		character.position.x = tile_size * PlayerInfo.playerDetails[player_index].x_offset
		add_child(character)
