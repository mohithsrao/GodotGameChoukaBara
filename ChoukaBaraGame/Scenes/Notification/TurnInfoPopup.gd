extends AcceptDialog

var sprite: Sprite
var okButton:Button

var defaultImage : Texture = preload("res://Assets/Player/L.png")
var playerImage : Texture

func _ready():
	var closeButton = get_close_button()
	closeButton.visible = false
	okButton = get_ok()
	sprite = $VBoxContainer/CenterContainer/Sprite

func Initialize(player:Player) -> void:
	playerImage = PlayerInfo.playerDetails[player.player_index].texture
	if(sprite):
		if (playerImage):
			sprite.texture = playerImage
		else:
			sprite.texture = defaultImage
