extends Node2D

var lvl1 = "res://Levels/Level1.tscn"
var lvl2 = "res://Levels/Level2.tscn"
var opener = "res://Levels/opener.tscn"
var menu = "res://Levels/StartMenu.tscn"
var restart = "res://Levels/Restart.tscn"
var win = "res://Levels/win.tscn"
var checkpoint = ""

func _ready():
	change("0")

func _process(delta):
	if Input.is_action_just_pressed("ui_restart") and checkpoint != "-1":
		change(checkpoint)

func change(var lvl):
	match lvl:
		"0":
			clear()
			add_child(load(menu).instance())
		"0.5":
			clear()
			add_child(load(opener).instance())	
		"1":
			clear()
			checkpoint = "1"
			add_child(load(lvl1).instance())
		"2":
			clear()
			checkpoint = "2"
			add_child(load(lvl2).instance())
		"3":
			clear()
			add_child(load(win).instance())
		99:
			clear()
			add_child(load(restart).instance())
	
		
func restart(level):
	change(99)
		
		
func clear():
	for n in self.get_children():
		if n.name != "music":
			self.remove_child(n)


