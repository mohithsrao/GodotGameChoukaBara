extends Node

class_name Player

signal pawnSelected

export var speed = 2
export var tile_size = 192
export(int,"One","Two","Three","Four") var player_index = 0

onready var navigation = $Navigation2D
onready var navigationPoly = $Navigation2D/NavigationPolygonInstance
onready var homeBase = $HomeBase

var pawnScene = preload("res://Scenes/Player/Pawn.tscn")
var maxCharactersPerPlayer = 4
var needsReRoll:bool = false
var selectedPawn : Pawn setget selectedPawn_set, selectedPawn_get
func selectedPawn_set(value) -> void:
	selectedPawn = value
	emit_signal("pawnSelected")

func selectedPawn_get() -> Pawn:
	return selectedPawn

# Called when the node enters the scene tree for the first time.
func _ready():
	homeBase.position += Vector2(PlayerInfo.playerDetails[player_index].x_offset,PlayerInfo.playerDetails[player_index].y_offset) * tile_size
	allignNavigationNode()
	homeBase.connect("area_entered",self,"_on_homeBase_area_entered")
	
	for playerIndex in range(0,maxCharactersPerPlayer):
		var character = pawnScene.instance()
		(character.get_node("Sprite") as Sprite).texture = PlayerInfo.playerDetails[player_index].texture
		character.name =  "Player_" + str(player_index) + "_" + str(playerIndex)
		character.initialSetup(speed,tile_size,playerIndex)
		character.position = character.position.snapped(Vector2.ONE * tile_size)
		character.position.y = tile_size * PlayerInfo.playerDetails[player_index].y_offset
		character.position.x = tile_size * PlayerInfo.playerDetails[player_index].x_offset
		character.add_to_group(self.name)
		add_child(character)

func _on_homeBase_area_entered(area:Area2D):
	var pawn = area.get_parent()
	pawn.call_deferred("disableHitBox")
		
func allignNavigationNode() -> void:
	navigation.position = PlayerInfo.navigationData[player_index].position
	navigation.rotation_degrees = PlayerInfo.navigationData[player_index].rotation
	navigationPoly.position = PlayerInfo.navigationData[player_index].position
	navigationPoly.rotation_degrees = PlayerInfo.navigationData[player_index].rotation

func getHomebasePosition() -> Vector2:
	return homeBase.position

