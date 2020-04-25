extends Node2D

var selectedCharacter
var tile_size : = 192

onready var playerSpawnerOneInstance : = $PlayerSpawnerOne
onready var playerSpawnerTwoInstance : = $PlayerSpawnerTwo
onready var playerSpawnerThreeInstance : = $PlayerSpawnerThree
onready var playerSpawnerFourInstance : = $PlayerSpawnerFour

func _ready() -> void:
	for character in playerSpawnerOneInstance.get_children():
		character.connect("character_selected",self,"_on_character_selected")
		character.connect("character_unselected",self,"_on_character_unselected")
	for character in playerSpawnerTwoInstance.get_children():
		character.connect("character_selected",self,"_on_character_selected")
		character.connect("character_unselected",self,"_on_character_unselected")
	for character in playerSpawnerThreeInstance.get_children():
		character.connect("character_selected",self,"_on_character_selected")
		character.connect("character_unselected",self,"_on_character_unselected")
	for character in playerSpawnerFourInstance.get_children():
		character.connect("character_selected",self,"_on_character_selected")
		character.connect("character_unselected",self,"_on_character_unselected")

func _unhandled_input(event : InputEvent) -> void:
	if event is InputEventMouseButton and selectedCharacter != null:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var navigationInstance = getNavigationInstanceforSelectedCharactor(selectedCharacter)
			var path = navigationInstance.get_simple_path(selectedCharacter.position, event.position)
			var normalizedPath = normalizeNavigationPath(path)
			selectedCharacter.navigationPath = normalizedPath
			$Line2D.points = normalizedPath

func getNavigationInstanceforSelectedCharactor(selectedCharacter):
	var navigationInstance = selectedCharacter.get_node("../Navigation2D")
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
	 
func _on_character_selected(character) -> void:
	selectedCharacter = character

func _on_character_unselected() -> void:
	selectedCharacter = null
	$Line2D.clear_points()
