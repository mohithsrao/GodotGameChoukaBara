extends "res://addons/gut/test.gd"

var PlayerScene: PackedScene = preload("res://Scenes/Player/Player.tscn")
var player = PlayerScene.instance()

func before_all():
	gut.p("Runs once before all tests")
	var child = add_child(player)
	PlayerInfo.active_player = player
	
func before_each():
	gut.p("Runs before each test.")

func after_each():
	gut.p("Runs after each test.")

func after_all():
	gut.p("Runs once after all tests")
	player.free()

func test_player_is_not_null():
	assert_not_null(player)

func test_CheckScript_is_not_null():
	var checkScript = player.get_node("CheckPlayerTurnValidity").get_script()
	assert_not_null(checkScript)
	
func test_player_gara_should_fail_when_no_pawn_can_move():
	var garaList = [8,8,8,8,8,8,8,8,8,2]
	var checkNodeScript = player.get_node("CheckPlayerTurnValidity")

	var result = checkNodeScript.CheckPlayerTurnForGara(garaList)

	assert_false(result,"Should pass when no pawns are able to move")
