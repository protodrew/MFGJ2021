extends Node2D


var diffused = false

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_kill_body_entered(body):
	if body.is_in_group("player") and !diffused:
		get_parent().get_parent().restart(get_parent().name.substr(get_parent().name.length() - 1, 1))


func _on_diffuse_body_entered(body):
	if body.is_in_group("player"):
			diffused = true
			print(diffused)
