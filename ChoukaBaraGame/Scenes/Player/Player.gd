extends Area2D

class_name Pawn

signal pawn_selected
signal pawn_unselected
signal destination_selected

onready var tween : Tween = $Tween
onready var ray : RayCast2D = $RayCast2D
onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var sprite : Sprite = $Sprite

var speed : int = 2
var tile_size : int = 192
var initial_character_position : int
var navigationPath: = PoolVector2Array() setget set_navigationPath

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}
var initialPosition = {
	 0: { "x_offset": 1,"y_offset":1 }
	,1: { "x_offset": 1,"y_offset":2 }
	,2: { "x_offset": 2,"y_offset":1 }
	,3: { "x_offset": 2,"y_offset":2 }
}

func _ready():	
	position.y += (tile_size / 3.0) * initialPosition[initial_character_position].y_offset
	position.x += (tile_size / 3.0) * initialPosition[initial_character_position].x_offset
	# Adjust animation speed to match movement speed
	animationPlayer.playback_speed = speed

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			var parent = get_parent()
			if (parent == PlayerInfo.active_player):
				if(PlayerInfo.active_player.selectedPawn == null || PlayerInfo.active_player.selectedPawn.get_index() != self.get_index()):
					select_pawn(self)
				else:
					unselect_pawn()
				
#func _process(_delta):
	# use this if you want to only move on keypress
	# func _unhandled_input(event):
#	if tween.is_active():
#		return
#	if(navigationPath.size() > 0):
#		var distance_to_next_point = global_position.distance_to(navigationPath[0])
#		if(distance_to_next_point <= tile_size/2.0):
#			navigationPath.remove(0)
#		else:
#			var angleToDestination : = rad2deg(global_position.angle_to_point(navigationPath[0]))
#			if(angleToDestination < 45 and angleToDestination >= - 45):
#				move("left")
#			if(angleToDestination < - 45 and angleToDestination >= - 45 * 3):
#				move("down")
#			if(angleToDestination < - 45 * 3 or angleToDestination >= 45 * 3):
#				move("right")
#			if(angleToDestination < 45 * 3 and angleToDestination >= 45):
#				move("up")
#	else:
#		set_process(false)
#		emit_signal("character_unselected")
#		sprite.scale = Vector2(1,1)

func set_navigationPath(value:PoolVector2Array) -> void:
	navigationPath = value
	emit_signal("destination_selected")
		
func move(dir : String) -> void:
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		animationPlayer.play(dir)
		move_tween(inputs[dir])
	
func move_tween(dirVector : Vector2) -> void:
	var _dummy0 = tween.interpolate_property(self
					,"position"
					,position
					,position + dirVector * tile_size
					,1.0/speed
					,Tween.TRANS_LINEAR
					,Tween.EASE_IN_OUT)
	var _dummy1 = tween.start()

func initialSetup(localSpeed,tileSize,local_initial_character_position) -> void:
	self.speed = localSpeed
	self.tile_size = tileSize
	self.initial_character_position = local_initial_character_position	
	
func select_pawn(pawn:Pawn) -> void:
	PlayerInfo.active_player.selectedPawn = pawn
	sprite.scale = Vector2(1.5,1.5)
	emit_signal("pawn_selected")

func unselect_pawn() -> void:
	PlayerInfo.active_player.selectedPawn = null
	sprite.scale = Vector2(1,1)
	emit_signal("pawn_unselected")
