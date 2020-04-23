extends Node2D

var selectedCharacter

onready var playerSpawnerInstance = $PlayerSpawner

func _ready():
	for character in playerSpawnerInstance.get_children():
		character.connect("character_selected",self,"_on_character_selected")
	 
func _on_character_selected(character):
	selectedCharacter = character
