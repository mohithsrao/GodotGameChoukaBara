extends Area2D

onready var tween = $Tween
onready var ray = $RayCast2D
onready var animationPlayer = $AnimationPlayer

signal character_selected

var speed = 2
var tile_size = 192
var initial_character_position

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
	position.y += (tile_size / 3) * initialPosition[initial_character_position].y_offset
	position.x += (tile_size / 3) * initialPosition[initial_character_position].x_offset
	# Adjust animation speed to match movement speed
	animationPlayer.playback_speed = speed

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			emit_signal("character_selected",self)
	
func _process(delta):
	# use this if you want to only move on keypress
	# func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			move(dir)
		
func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		animationPlayer.play(dir)
		move_tween(inputs[dir])
	
func move_tween(dirVector):
	tween.interpolate_property(self
					,"position"
					,position
					,position + dirVector * tile_size
					,1.0/speed
					,Tween.TRANS_LINEAR
					,Tween.EASE_IN_OUT)
	tween.start()

func initialSetup(speed,tileSize,initial_character_position):
	self.speed = speed
	self.tile_size = tileSize
	self.initial_character_position = initial_character_position	
	
