extends Node2D

var selectedCharacter
var tile_size : = 192

onready var playerSpawnerOneInstance : = $PlayerSpawnerOne
onready var playerSpawnerTwoInstance : = $PlayerSpawnerTwo
onready var playerSpawnerThreeInstance : = $PlayerSpawnerThree
onready var playerSpawnerFourInstance : = $PlayerSpawnerFour
onready var line : Line2D = $Line2D

func _ready() -> void:
	for childNode in playerSpawnerOneInstance.get_children():
		connectToUserSignals(childNode)
	for childNode in playerSpawnerTwoInstance.get_children():
		connectToUserSignals(childNode)
	for childNode in playerSpawnerThreeInstance.get_children():
		connectToUserSignals(childNode)
	for childNode in playerSpawnerFourInstance.get_children():
		connectToUserSignals(childNode)

func _unhandled_input(event : InputEvent) -> void:
	if event is InputEventMouseButton and selectedCharacter != null:
		var inpEvent : InputEventMouseButton = event as InputEventMouseButton
		if inpEvent.button_index == BUTTON_LEFT and inpEvent.pressed:
			var navigationInstance = getNavigationInstanceforSelectedCharactor(selectedCharacter)
			var path = navigationInstance.get_simple_path(selectedCharacter.position, inpEvent.position)
			var normalizedPath = normalizeNavigationPath(path)
			selectedCharacter.navigationPath = normalizedPath
			line.points = normalizedPath

func connectToUserSignals(node:Node2D) -> void:
	if(node.has_user_signal("character_selected")):
		node.connect("character_selected",self,"_on_character_selected")
	if(node.has_user_signal("character_unselected")):
		node.connect("character_unselected",self,"_on_character_unselected")

func getNavigationInstanceforSelectedCharactor(character):
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
	 
func _on_character_selected(character) -> void:
	selectedCharacter = character

func _on_character_unselected() -> void:
	selectedCharacter = null
	line.clear_points()
