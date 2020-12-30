extends Area2D

class_name Pawn

signal pawn_selected
signal pawn_unselected

signal movement_round_complete

var notification_scene = preload("res://Scenes/HUD/NotifiationText.tscn")

onready var tween : Tween = $Tween
onready var ray : RayCast2D = $RayCast2D
onready var animationPlayer : AnimationPlayer = $AnimationPlayer
onready var sprite : Sprite = $Sprite
onready var hitboxCollision = $Hitbox/CollisionShape2D
onready var hitbox = $Hitbox
onready var hurtbox = $Hurtbox
onready var hurtboxCollision = $Hurtbox/CollisionShape2D
onready var notificationRoot = $NotificationRoot

var pawnHit = false
var speed : int = 2
var tile_size : int = 192
var initial_character_position : int
var moveCount:int = 0
var garaValue:int = 0
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
var currentLocation:int = 0

func _ready():	
	set_process(false)
	position.y += (tile_size / 3.0) * initialPosition[initial_character_position].y_offset
	position.x += (tile_size / 3.0) * initialPosition[initial_character_position].x_offset
	# Adjust animation speed to match movement speed
	animationPlayer.playback_speed = speed
	call_deferred("disableHitBox")
	hurtbox.connect("area_entered",self,"_on_hurtbox_area_entered")

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			var parent = get_parent()
			if (parent == PlayerInfo.active_player):
				if(PlayerInfo.active_player.selectedPawn == null || PlayerInfo.active_player.selectedPawn.get_index() != self.get_index()):
					select_pawn(self)
				else:
					unselect_pawn()

func removeFirstElementFromNavigationPath() -> void:
	navigationPath.remove(0)

func clearNavigationPath():
	navigationPath.resize(0)

func set_navigationPath(value:PoolVector2Array) -> void:
	if(value != null):
		set_process(true)
	navigationPath = value

func initialSetup(localSpeed,tileSize,local_initial_character_position) -> void:
	self.speed = localSpeed
	self.tile_size = tileSize
	self.initial_character_position = local_initial_character_position	

func resetAnimation() -> void:
	animationPlayer.queue("down")
	
func select_pawn(pawn:Pawn) -> void:
	PlayerInfo.active_player.selectedPawn = pawn
	sprite.scale = Vector2(1.5,1.5)	
	emit_signal("pawn_selected")

func unselect_pawn() -> void:
	PlayerInfo.active_player.selectedPawn = null
	sprite.scale = Vector2(1,1)
	emit_signal("pawn_unselected")

func disableHitBox() -> void:
	hitboxCollision.disabled = true
	hurtboxCollision.disabled = true

func enableHitBox(andGetHurt:bool) -> void:
	hitboxCollision.disabled = false
	hurtboxCollision.disabled = andGetHurt
	
func _on_hurtbox_area_entered(areaEntered:Area2D):
	var enteredPawn = areaEntered.get_parent()
	var enteredPlayer = enteredPawn.get_parent()
	var selfPlayer = self.get_parent()
	if(self.get_instance_id() == enteredPawn.get_instance_id() 
	|| selfPlayer.get_instance_id() == enteredPlayer.get_instance_id()):
		return
	if(self.get_parent().player_index == PlayerInfo.active_player.player_index):
		return
	if(selfPlayer.get_instance_id() != enteredPlayer.get_instance_id()):
		pawnHit = true
		PlayerInfo.active_player.canEnterInnerCircle = true
		PlayerInfo.active_player.needsReRoll = true

func canMoveSelectedTurn(gara:int)-> bool:
	var positionToBeMoved = currentLocation + gara
	var notification = ""
	var result = true
	if(not PlayerInfo.active_player.canEnterInnerCircle && not (positionToBeMoved <= GameUtility.distanceToGoal)):
		notification = "Cannot enter goal as steps is greaer than goal distance"
		result = false
	elif (not (positionToBeMoved < GameUtility.distanceToInnerCircle)):
		notification = "Cannot enter inner circle as Player HIT not performed"
		result = false
	
	if (not notification.empty()):
		showNotification(notification)
	
	return result

func showNotification(notificationText:String):
	var notification_instance = notification_scene.instance()
	notification_instance.notificationString = notificationText
	notificationRoot.add_child(notification_instance)
