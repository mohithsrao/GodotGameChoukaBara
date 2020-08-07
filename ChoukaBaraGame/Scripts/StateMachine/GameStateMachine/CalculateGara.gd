extends IState

var koudePopup = preload("res://Scenes/Gara/GaraPopup.tscn")

func update(_delta):
	if(get_tree().current_scene.has_node("/root/Game/GaraPopup") or get_tree().current_scene.has_node("/root/Game/TurnInfo")):
		return
	yield(RollKoude(),"completed")
	emit_signal("finished","SelectPawn")

func RollKoude() -> void:
	var popupInstance = koudePopup.instance()
	popupInstance.connect("gara_completed",self,"_on_popup_gara_complete")
	get_parent().get_parent().add_child(popupInstance)
	yield(popupInstance,"confirmed")
	popupInstance.queue_free()

func _on_popup_gara_complete(list:Array):
	for item in list:
		PlayerInfo.garaList.append(item)
