extends Node2D

var selectedCharacter

onready var playerSpawnerInstance = $PlayerSpawner

func _ready():
	for character in playerSpawnerInstance.get_children():
		character.connect("character_selected",self,"_on_character_selected")

func _unhandled_input(event):
	if event is InputEventMouseButton and selectedCharacter != null:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var path = $Navigation2D.get_simple_path(selectedCharacter.position, event.position)
			$Line2D.points = path
			selectedCharacter.navigationPath = path
	 
func _on_character_selected(character):
	selectedCharacter = character
