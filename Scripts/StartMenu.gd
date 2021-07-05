extends Node2D

var selected_menu = 0
onready var sfx = $sfx
var up = load("res://sfx/up.wav")
var down = load("res://sfx/down.wav")
var start = load("res://sfx/start.wav")
func _ready():
	change_menu_color()
	

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 3;
		change_menu_color()
		sfx.set_stream(down)
		sfx.play()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
			selected_menu = selected_menu - 1
		else:
			selected_menu = 2
		sfx.set_stream(up)
		sfx.play()
		
		change_menu_color()
	elif Input.is_action_just_pressed("ui_accept"):
		sfx.set_stream(start)
		sfx.play()
		

func change_menu_color():
	$StartButton.color = Color.gray
	$LoadGame.color = Color.gray
	$Quit.color = Color.gray
	
	match selected_menu:
		0:
			$StartButton.color = Color.greenyellow
		1:
			$LoadGame.color = Color.greenyellow
		2:
			$Quit.color = Color.greenyellow

func _on_sfx_finished():
	if sfx.get_stream() == start:
		match selected_menu:
			0:
				# New game
				get_parent().change("1")
			1:
				# Load game
				var next_level_resource = load("res://Levels/Lvl 2.tscn");
				var next_level = next_level_resource.instance()
				next_level.load_saved_game = true
				get_tree().root.call_deferred("add_child", next_level)
				queue_free()
			2:
				# Quit game
				get_tree().quit()
