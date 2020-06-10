extends Control

onready var animSprite = $MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerInfo.connect("player_changed",self,"_on_player_changed")


func _on_player_changed(player:Player) -> void:
	animSprite.animation = str(player.player_index)
