extends Node

var active_player:Player

var playerDetails = {
	 0: { "x_offset": 0,"y_offset":2, "texture": preload("res://Assets/Player/L.png") }
	,1: { "x_offset": 2,"y_offset":4, "texture": preload("res://Assets/Player/lightyagami.png") }
	,2: { "x_offset": 4,"y_offset":2, "texture": preload("res://Assets/Player/misaamane.png") }
	,3: { "x_offset": 2,"y_offset":0, "texture": preload("res://Assets/Player/ryuk.png") }
}

var navigationData = {
	 0: { "position": Vector2(0,0), "rotation": 0.0 }
	,1: { "position": Vector2(0,960), "rotation": -90.0 }
	,2: { "position": Vector2(960,960), "rotation": -180.0 }
	,3: { "position": Vector2(960,0), "rotation": -270.0 }
}
