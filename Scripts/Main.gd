extends Node2D

var lvl1 = preload("res://Levels/Level1.tscn").instance()
var menu = preload("res://Levels/StartMenu.tscn").instance()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(menu)
	
func change(var lvl):
	if lvl == "1":
		remove_child(menu)
		add_child(lvl1)
