extends Node

var active_player:Player

var playerDetails = {
	 0: { "x_offset": 0,"y_offset":2, "texture": preload("res://Assets/Player/L.png") }
	,1: { "x_offset": 2,"y_offset":4, "texture": preload("res://Assets/Player/lightyagami.png") }
	,2: { "x_offset": 4,"y_offset":2, "texture": preload("res://Assets/Player/misaamane.png") }
	,3: { "x_offset": 2,"y_offset":0, "texture": preload("res://Assets/Player/ryuk.png") }
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
