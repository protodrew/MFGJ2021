extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var col = $Area2D
var timer = 120;

func _physics_process(delta):
	if timer <= 0:
		queue_free()
	
		timer -= 1
