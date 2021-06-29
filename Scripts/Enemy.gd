extends KinematicBody2D

signal state_changed(new_state)
onready var col = $Area2D
var player = null
const SPEED = 50
const patrolsize = 100
var velocity = Vector2.ZERO

enum States{
	PATROL,
	ENGAGE
}
# Called when the node enters the scene tree for the first time.
var current_state = States.PATROL setget set_state

func set_state(new_state: int ):
	if new_state == current_state:
		return
	
	current_state = new_state
	emit_signal("state_changed", current_state)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		set_state(States.ENGAGE)
		player = body
		



func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		set_state(States.PATROL)
		player = null
	
func _process(delta):
	match current_state:
		States.ENGAGE:
			velocity = position.direction_to(player.position) * SPEED
		States.PATROL:
			velocity = Vector2.ZERO
		
	
	velocity = move_and_slide(velocity)

