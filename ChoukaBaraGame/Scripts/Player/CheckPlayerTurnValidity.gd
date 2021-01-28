extends Node

func CheckPlayerTurnForGara(garaList:Array) -> bool:
	var parent = get_parent()
	var children = parent.get_children()
	var crieteria = funcref(self,"_GetPawns")
	var pawnChildren = _filter(children,crieteria)
	
	var canPlayerMovePawn = false
	for pawn in pawnChildren:
		var canPawnMove = false
		var previousGara:int = 0
		for n in range(garaList.size()):
			if(n != 0):
				previousGara = garaList[n-1]
			var currentGara:int =  garaList[n]
			var garaToCheck = previousGara + currentGara
			canPawnMove = (pawn as Pawn).canMoveSelectedTurn(garaToCheck,false)
		if(canPawnMove):
			canPlayerMovePawn = true
			break
	
	return canPlayerMovePawn

func _GetPawns(child) -> bool:
	return child is Pawn;
	
func _filter(list: Array, matches_criteria: FuncRef) -> Array:
	# Usually better to add filtered elements to new array
	# because removing elements while iterating over a list
	# causes weird behaviour
	var filtered: Array = []
	for element in list:
		if matches_criteria.call_func(element):
			filtered.append(element)
	return filtered	
