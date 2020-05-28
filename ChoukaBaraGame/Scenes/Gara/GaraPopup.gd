extends AcceptDialog

signal gara_completed(garaList)

onready var koude01 = $VBoxContainer/HBoxContainer2/koude01
onready var koude02 = $VBoxContainer/HBoxContainer2/koude02
onready var koude03 = $VBoxContainer/HBoxContainer3/koude03
onready var koude04 = $VBoxContainer/HBoxContainer3/koude04

var garaList : Array = []
var list : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var closeButton = get_close_button()
	closeButton.visible = false
	garaList.clear()
	popup_centered()
	var repeat : bool = true
	while repeat:
		list.append(getState())
		koude01.setState(list[0],1)
		list.append(getState())
		koude02.setState(list[1],2)
		list.append(getState())
		koude03.setState(list[2],3)
		list.append(getState())
		koude04.setState(list[3],4)
		var count = list.count(true)
		repeat = count == 0 || count == 4
		if(count == 0):
			count = 8
		garaList.append(count)
		list.clear()
	
	emit_signal("gara_completed",garaList)

func getState() -> bool:
	var koudeRoll = randi() % 2
	if(koudeRoll == 0):
		return false
	else:
		return true
