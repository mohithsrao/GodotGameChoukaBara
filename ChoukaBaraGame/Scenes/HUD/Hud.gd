extends CanvasLayer

onready var animSprite = $MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/AnimatedSprite
onready var moveList = $MarginContainer/VBoxContainer2/VBoxContainer2/ItemList

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerInfo.connect("player_changed",self,"_on_player_changed")

func _on_player_changed(player:Player) -> void:
	if(player):
		animSprite.animation = str(player.player_index)

func _process(_delta):
	moveList.visible = !PlayerInfo.garaList.empty()
	moveList.clear()
	var remString = ""
	for item in PlayerInfo.garaList:
		moveList.add_item(str(item),null,false)
	
