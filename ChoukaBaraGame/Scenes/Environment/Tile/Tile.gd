"""
Tile class is the base class for all different Tiles in game like
1) Home Tile
2) Goal Tile
3) Inner Tile
4) Outer Tile

The Use of this class is to abstract the Tile Feature used in this game

"""
extends Area2D
class_name Tile

signal pawn_entered(pawn)
signal pawn_exited(pawn)

var signalResource = SignalResource.new()

var residingPawns:Array = []

func _ready() -> void:
	signalResource.connect_signal("area_entered",self,"_on_tile_area_entered")
	signalResource.connect_signal("area_exited",self,"_on_tile_area_exited")

func _on_tile_area_entered(area:Area2D)-> void:
	var pawn = area as Pawn
	if (pawn):
		residingPawns.append(pawn)
		emit_signal("pawn_entered",pawn)

func _on_tile_area_exited(area:Area2D)-> void:
	var pawn = area as Pawn
	if (pawn):
		residingPawns.erase(pawn)
		emit_signal("pawn_exited",pawn)
