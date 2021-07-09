extends KinematicBody2D

var inview = false
var question = preload("res://Scenes/huh.tscn").instance()
var exclamation = preload("res://Scenes/AHA.tscn").instance()
var count = 20
var speed = 30
onready var shape = $CollisionShape2D

func _process(delta):
	if inview == false:
		if count < 20:
			count += 1
	else:
		count -= 1
		
	if count == 0:
		get_parent().get_parent().restart(get_parent().name.substr(get_parent().name.length() - 1, 1))
		
	if rotation_degrees == 0 or rotation_degrees == 180:
		move_and_slide(Vector2(0,speed))
	else:
		move_and_slide(Vector2(-speed,0))
		
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		inview = true
		remove_child(question)
		var AHA = add_child(exclamation)
	
	if body.is_in_group("wall"):
		speed *= -1
		rotation_degrees += 180
		
func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		inview = false
		remove_child(exclamation)
		var huh = add_child(question)
