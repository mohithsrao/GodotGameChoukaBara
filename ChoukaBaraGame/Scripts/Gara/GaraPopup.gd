extends AcceptDialog

signal gara_completed(garaList)

onready var koude01 = $VBoxContainer/HBoxContainer2/koude01
onready var koude02 = $VBoxContainer/HBoxContainer2/koude02
onready var koude03 = $VBoxContainer/HBoxContainer3/koude03
onready var koude04 = $VBoxContainer/HBoxContainer3/koude04
onready var addButton: Button = add_button("Roll Again!!",true,"roll_again")
onready var okButton = get_ok()

export var is_Debug:bool = false

var garaList : Array = []
var list : Array = []
var repeat : bool = true
var multiplier:float;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if(is_Debug):
		multiplier = 0.01
	else:
		multiplier = 1
	var closeButton = get_close_button()
	closeButton.visible = false
	garaList.clear()
	koude04.connect("roll_finished",self,"_on_koude_roll_finished")
	addButton.visible = false
	popup_centered()
	while repeat:
		list.append(getState())
		koude01.setState(list[0],1 * multiplier)
		list.append(getState())
		koude02.setState(list[1],2 * multiplier)
		list.append(getState())
		koude03.setState(list[2],3 * multiplier)
		list.append(getState())
		koude04.setState(list[3],4 * multiplier)
		var count = list.count(true)
		repeat = count == 0 || count == 4
		if(count == 0):
			count = 8
		garaList.append(count)
		list.clear()
		if(repeat):
			yield(self,"custom_action")
	
	addButton.visible = false
	okButton.visible = true
	emit_signal("gara_completed",garaList)

func getState() -> bool:
#	return true
	var koudeRoll = randi() % 2
	if(koudeRoll == 0):
		return false
	else:
		return true

func _on_koude_roll_finished():
	dialog_text =  update_gara_text()
	if(repeat):
		okButton.visible = false
		addButton.visible = true

func update_gara_text() -> String:
	var text = "You rolled"
	var scoreText = ""
	for gara in garaList:
		scoreText += ", " + str(gara) 
	
	text += scoreText
	return text
