"""
HomeTile class is derived from base class Tile
The Use of this class is to define all the features needed in home base
"""
extends Tile
class_name HomeTile

func _ready():
	signalResource.connect_signal("pawn_entered",self,"_on_pawn_entered")
	signalResource.connect_signal("pawn_exited",self,"_on_pawn_exited")

func _on_pawn_entered(pawn:Pawn):
	pass

func _on_pawn_exited(pawn:Pawn):
	pass
