extends CenterContainer

class_name Koude

signal roll_finished

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var timer = $Timer

var openShell = preload("res://Assets/Shells/Shell_001_Open.png")
var closeShell = preload("res://Assets/Shells/Shell_001_Close.png")

func setState(state:bool,timerDelay:float)->void:
	animationPlayer.play("play")
	timer.start(timerDelay)
	yield(timer,"timeout")
	animationPlayer.stop(true)
	if(state):
		sprite.texture = openShell
	else:
		sprite.texture = closeShell
	emit_signal("roll_finished")
