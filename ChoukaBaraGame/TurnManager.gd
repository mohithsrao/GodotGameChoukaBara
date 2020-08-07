extends YSort
class_name TurnManager

export(int,"One","Two","Three","Four") var NUMBER_OF_PLAYERS

var player = preload("res://Scenes/Player/Player.tscn")

func _ready():
	for i in range(NUMBER_OF_PLAYERS+1):
		var playerInstance = player.instance()
		playerInstance.name = "Player-"+str(i)
		playerInstance.player_index = i
		playerInstance.add_to_group(GameUtility.Group_Player)		
		add_child(playerInstance)
