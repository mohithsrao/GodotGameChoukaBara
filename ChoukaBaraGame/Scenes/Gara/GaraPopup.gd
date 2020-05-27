extends AcceptDialog

onready var koude01 = $VBoxContainer/HBoxContainer2/koude01
onready var koude02 = $VBoxContainer/HBoxContainer2/koude02
onready var koude03 = $VBoxContainer/HBoxContainer3/koude03
onready var koude04 = $VBoxContainer/HBoxContainer3/koude04

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	popup_centered()
	koude01.setState(getState(),1)
	koude02.setState(getState(),2)
	koude03.setState(getState(),3)
	koude04.setState(getState(),4)

func getState() -> bool:
	var koudeRoll = randi() % 2
	if(koudeRoll == 0):
		return false
	else:
		return true
