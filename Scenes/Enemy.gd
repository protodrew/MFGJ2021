extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var cast = $RayCast2D
onready var col = $Area2D
var entered = false;
var player = null
# Called when the node enters the scene tree for the first time.



func _on_Area2D_body_entered(body):
	player = body
	entered = true;
	
		
func _process(delta):
	if entered:
		fov()
	else:
		cast.set_cast_to(Vector2(0,0))


func _on_Area2D_body_exited(body):
	entered = false;

func fov():
	cast.set_cast_to(Vector2(player.position.x-8,player.position.y-8))
	if cast.get_collider() != null and cast.get_collider().name == "Player":
	 print("shown")
	else:
		print("hidden")
		
