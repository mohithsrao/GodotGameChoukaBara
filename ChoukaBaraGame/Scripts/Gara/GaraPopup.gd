extends AcceptDialog

signal gara_completed(garaList)

onready var koude01 = $VBoxContainer/HBoxContainer2/koude01
onready var koude02 = $VBoxContainer/HBoxContainer2/koude02
onready var koude03 = $VBoxContainer/HBoxContainer3/koude03
onready var koude04 = $VBoxContainer/HBoxContainer3/koude04
var buttonRollAgain: Button
var buttonSelectPawn: Button
var buttonCentrePos: Vector2
var buttonPrevPos: Vector2
onready var okButton = get_ok()
# var okButtonPos: Vector2

var garaList : Array = []
var list : Array = []
var repeat : bool = true


func initButtons():
	#centre position for the button
	buttonCentrePos.x = 309
	buttonCentrePos.y = 0

	buttonRollAgain = add_button("Roll Again!!",true,"roll_again")
	buttonRollAgain.visible = false

	buttonSelectPawn = add_button("Select Pawn", true)
	buttonSelectPawn.visible = false

	okButton.visible = false
	# okButton.text = "Select Pawn"
	# okButtonPos.x = 309 # button centering
	# okButtonPos.y = 100 # button centering
	# okButton.visible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	initButtons()
	randomize()
	var closeButton = get_close_button()
	closeButton.visible = false
	garaList.clear()
	koude04.connect("roll_finished",self,"_on_koude_roll_finished")

	
func getState() -> bool:
	#debug
#	return true
	var koudeRoll = randi() % 2
	if(koudeRoll == 0):
		return false
	else:
		return true

func _on_koude_roll_finished():
	dialog_text =  update_gara_text()
	if(repeat):
		# okButton.visible = false
		if buttonRollAgain:
			buttonPrevPos = buttonRollAgain.rect_position
			buttonRollAgain.visible = true	
			buttonRollAgain.rect_position = buttonCentrePos
	else:
		if buttonRollAgain:
			buttonRollAgain.visible = false	
			buttonRollAgain.rect_position = buttonPrevPos

		if buttonSelectPawn:
			buttonPrevPos = buttonSelectPawn.rect_position
			buttonSelectPawn.visible = true

		""" okButton.rect_position = okButtonPos
		okButton.visible = true """
		
#		okButton.margin_bottom = okMarginBotton
#		okButton.margin_right = okMarginRight
#		okButton.margin_left = okMarginLeft
#		okButton.margin_top = okMarginTop
		

func update_gara_text() -> String:
	var text = "You rolled"
	var scoreText = ""
	for gara in garaList:
		scoreText += ", " + str(gara) 
	
	text += scoreText
	return text
	
	
func roll():
	popup_centered()
#	okButtonPos = okButton.rect_position
#	okMarginBotton = okButton.margin_bottom
#	okMarginRight = okButton.margin_right
#	okMarginLeft = okButton.margin_left
#	okMarginTop = okButton.margin_top
#	okButton.visible = false
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
		if(repeat):		
			yield(self,"custom_action")
				
	emit_signal("gara_completed",garaList)
