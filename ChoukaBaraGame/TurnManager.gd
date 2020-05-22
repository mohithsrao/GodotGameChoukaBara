extends YSort

class_name TurnManager

onready var active_player:Player

func Initilize() -> void:
	var players = get_children()
	players.sort_custom(self,'sortPlayers')
	for player in players:
		player.raise()
	active_player = get_child(0)

func sortPlayers(playerOne:Player,playerTwo:Player) -> bool:
	return playerOne.player_index > playerTwo.player_index

func play_turn():	
	yield(active_player.play_turn(),'completed')
	selectNextPlayer()
	
func selectNextPlayer():
	var next_battler_index: int = (active_player.get_index() + 1) % get_child_count()
	active_player = get_child(next_battler_index)
