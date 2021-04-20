extends WATTest

var gameBoard = preload("res://Resources/GameBoards/5x5GameBoard.tres")
var tile_manager:PackedScene  = preload("res://Scenes/Environment/TileManager/TileManager.tscn")

var unitUnderTest:TileManager

var editor_validation_strings:EditorValidationStringConstants = EditorValidationStringConstants.new()

func title() -> String:
	return "Tile Manager Unit Tests"

func pre() -> void:
	unitUnderTest = tile_manager.instance()

func test_validation_message_is_shown_when_game_board_variable_is_set_incorrectly():
	describe("should display validation message when game board is not set")
	var result = unitUnderTest._get_configuration_warning()
	asserts.is_String(result,"then it is a string message")
	var _result = asserts.Equality.is_equal(result,editor_validation_strings.ResourceRequiredValidationString.format({"variable":"game_board","type":"GameBoard"}),"then validation error is shown")

func test_validation_message_is_not_shown_when_game_board_variable_is_set_correctly():
	describe("should not display validation message when game board is set")
	unitUnderTest.game_board = gameBoard
	var result = unitUnderTest._get_configuration_warning()
	asserts.is_String(result,"then it is a string message")
	asserts.string_does_not_contain(editor_validation_strings.ResourceRequiredValidationString.format({"variable":"game_board","type":"GameBoard"}),"then validation error is not shown")

func test_on_ready_total_tile_count_matches_tiles_required():
	describe("should test that the total number of tiles generated is size squared")
	
	unitUnderTest._ready()
	
	var tileGeneratedCount = unitUnderTest.get_child_count()
	asserts.is_true(gameBoard.BoardDimension*gameBoard.BoardDimension == tileGeneratedCount)

func test_on_ready_home_tile_count_matches_tiles_In_GameBoard():
	describe("should test that number of home tiles generated is as required")
	
	unitUnderTest._ready()
	
	var tileGeneratedCount:int = 0
	
	for child in unitUnderTest.get_children():
		if child is HomeTile:
			tileGeneratedCount += 1
	asserts.is_true(gameBoard.HomeBaseCountOuterCircle.size() == tileGeneratedCount)

func test_on_ready_goal_tile_count_matches_tiles_In_GameBoard():
	describe("should test that number of goal tiles generated is as required")
	
	unitUnderTest._ready()
	
	var tileGeneratedCount:int = 0
	
	for child in unitUnderTest.get_children():
		if child is GoalTile:
			tileGeneratedCount += 1
	asserts.is_true(1 == tileGeneratedCount)

func test_on_ready_normall_tile_count_matches_tiles_In_GameBoard():
	describe("should test that number of normal tiles generated is as required")
	
	unitUnderTest._ready()
	
	var tileGeneratedCount:int = 0
	
	for child in unitUnderTest.get_children():
		if  not (child is GoalTile || child is HomeTile):
			tileGeneratedCount += 1
	var normalTileCount = (gameBoard.BoardDimension * gameBoard.BoardDimension) - gameBoard.HomeBaseCountOuterCircle.size() - 1
	asserts.is_true(normalTileCount == tileGeneratedCount)

func post() -> void:
	unitUnderTest.queue_free()
