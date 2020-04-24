extends Node2D

var selectedCharacter
var tile_size = 192

onready var playerSpawnerInstance = $PlayerSpawner

func _ready():
	for character in playerSpawnerInstance.get_children():
		character.connect("character_selected",self,"_on_character_selected")

func _unhandled_input(event):
	if event is InputEventMouseButton and selectedCharacter != null:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var path = $Navigation2D.get_simple_path(selectedCharacter.position, event.position)
			var normalizedPath = normalizeNavigationPath(path)
			selectedCharacter.navigationPath = normalizedPath
			$Line2D.points = normalizedPath

func normalizeNavigationPath(path:PoolVector2Array) -> PoolVector2Array:
	var resultArray = PoolVector2Array()
	for point in path:
		var modValueX = floor(point.x / (tile_size))
		var modValueY = floor(point.y / (tile_size))
		var newPoint = Vector2(
			 (modValueX * (tile_size)) + (tile_size / 2)
			,(modValueY * (tile_size)) + (tile_size / 2))
		
		resultArray.append(newPoint)
	
	return resultArray
	 
func _on_character_selected(character):
	selectedCharacter = character
