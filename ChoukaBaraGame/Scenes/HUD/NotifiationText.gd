extends Position2D

onready var lable = get_node("Label")
onready var tween = get_node("Tween")
var notificationString = ""

export var tween_duration  = 0.5
export var notification_length = 3

func _ready():
	lable.text = notificationString
	tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed")
	
	tween.interpolate_property(self, 'scale' , scale ,Vector2(1,1), tween_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, 'scale' ,Vector2(1,1), scale , tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN, notification_length)
	tween.start()

func _on_Tween_tween_all_completed():
	self.queue_free()
