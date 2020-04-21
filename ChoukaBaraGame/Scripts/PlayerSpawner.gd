extends Node

export var speed = 2
export var tile_size = 192
export(int,"One","Two","three","Four") var player_index = 0

var playerScene = preload("res://Scenes/Player/Player.tscn")
var maxCharactersPerPlayer = 4
var playerOffserForSpawn = {
	 0: { "x_offset": 0,"y_offset":2 }
	,1: { "x_offset": 2,"y_offset":4 }
	,2: { "x_offset": 4,"y_offset":2 }
	,3: { "x_offset": 2,"y_offset":0 }
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for playerIndex in range(0,maxCharactersPerPlayer):
		var character = playerScene.instance()
		character.initialSetup(speed,tile_size,playerIndex)
		character.position = character.position.snapped(Vector2.ONE * tile_size)
		character.position.y = tile_size * playerOffserForSpawn[player_index].y_offset
		character.position.x = tile_size * playerOffserForSpawn[player_index].x_offset
		add_child(character)
