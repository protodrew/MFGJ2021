extends KinematicBody2D

var inview = false
var question = preload("res://Scenes/huh.tscn").instance()
var exclamation = preload("res://Scenes/AHA.tscn").instance()
var count = 80

func _process(delta):
	if inview == false:
		if count < 80:
			count += 1
	else:
		count -= 1
		
	if count == 0:
		get_parent().get_parent().restart(get_parent().name.substr(get_parent().name.length() - 1, 1))
		
		
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		inview = true
		remove_child(question)
		var huh = add_child(exclamation)

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		inview = false
		remove_child(exclamation)
		var huh = add_child(question)
