extends Node2D

var lvl1 = "res://Levels/Level1.tscn"
var lvl2 = "res://Levels/Level2.tscn"
var menu = "res://Levels/StartMenu.tscn"
var restart = "res://Levels/Restart.tscn"
var checkpoint = "-1"

func _ready():
	change("1")

func _process(delta):
	if Input.is_action_just_pressed("ui_restart") and checkpoint != "-1":
		change(checkpoint)

func change(var lvl):
	match lvl:
		"0":
			clear()
			add_child(load(menu).instance())
		"1":
			clear()
			add_child(load(lvl1).instance())
		"2":
			clear()
			add_child(load(lvl2).instance())
		99:
			clear()
			add_child(load(restart).instance())
	
		
func restart(level):
	checkpoint = level
	change(99)
		
		
func clear():
	for n in self.get_children():
		self.remove_child(n)


