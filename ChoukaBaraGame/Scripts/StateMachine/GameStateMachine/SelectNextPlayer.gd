extends IState

func enter(owner):
	.enter(owner)
	var players = get_node("../../TurnManager").get_children()
	players.sort_custom(self,'sortPlayers')
	for player in players:
		player.raise()
	PlayerInfo.active_player = players[0]

func sortPlayers(playerOne:Player,playerTwo:Player) -> bool:
	return playerOne.player_index < playerTwo.player_index

func update(_delta):
	if(PlayerInfo.active_player):
		var next_battler_index: int = (PlayerInfo.active_player.get_index() + 1) % get_node("../../TurnManager").get_child_count()
		PlayerInfo.active_player = get_child(next_battler_index)
		emit_signal("finished","CalculateGara")
