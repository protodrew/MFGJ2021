extends StaticBody2D


onready var nextlevel = str(int(get_parent().name.substr(get_parent().name.length() - 1, 1)) + 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("cum")
		get_parent().get_parent().change(nextlevel)
