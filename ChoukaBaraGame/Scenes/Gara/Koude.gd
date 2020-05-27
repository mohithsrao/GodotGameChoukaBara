extends CenterContainer

class_name Koude

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var timer = $Timer

var openShell = preload("res://Assets/Shells/Shell_001_Open.png")
var closeShell = preload("res://Assets/Shells/Shell_001_Close.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("play")

func setState(state:bool,timerDelay:float)->void:
	timer.start(timerDelay)
	yield(timer,"timeout")
	animationPlayer.stop(true)
	if(state):
		sprite.texture = openShell
	else:
		sprite.texture = closeShell
