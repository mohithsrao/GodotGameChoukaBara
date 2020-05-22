extends Node

class_name Player

export var speed = 2
export var tile_size = 192
export(int,"One","Two","three","Four") var player_index = 0

var playerScene = preload("res://Scenes/Player/Player.tscn")
var maxCharactersPerPlayer = 4
var playerDetails = {
	 0: { "x_offset": 0,"y_offset":2, "texture": preload("res://Assets/Player/L.png") }
	,1: { "x_offset": 2,"y_offset":4, "texture": preload("res://Assets/Player/lightyagami.png") }
	,2: { "x_offset": 4,"y_offset":2, "texture": preload("res://Assets/Player/misaamane.png") }
	,3: { "x_offset": 2,"y_offset":0, "texture": preload("res://Assets/Player/ryuk.png") }
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for playerIndex in range(0,maxCharactersPerPlayer):
		var character = playerScene.instance()
		(character.get_node("Sprite") as Sprite).texture = playerDetails[player_index].texture
		character.name =  "Player_" + str(player_index) + "_" + str(playerIndex)
		character.initialSetup(speed,tile_size,playerIndex)
		character.position = character.position.snapped(Vector2.ONE * tile_size)
		character.position.y = tile_size * playerDetails[player_index].y_offset
		character.position.x = tile_size * playerDetails[player_index].x_offset
		add_child(character)
