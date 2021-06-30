extends KinematicBody2D

signal state_changed(new_state)
var player = null
const SPEED = 50
var velocity = Vector2.ZERO


var path = []
var target_point_world = Vector2()
var target_position = Vector2()



enum States{
	PATROL,
	ENGAGE
}

var current_state = States.PATROL setget set_state

func set_state(new_state):
	if new_state == States.ENGAGE:
		path = get_parent().get_node('Walls').find_path(position, target_position)
		if not path or len(path) == 1:
			set_state(States.PATROL)
			return
		# The index 0 is the starting cell
		# we don't want the character to move back to it in this example
		target_point_world = path[1]
	current_state = new_state


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		target_position = body.position
		set_state(States.ENGAGE)
		

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		set_state(States.PATROL)
		player = null
	
func _process(delta):
	print(States.keys()[current_state])
	if not current_state == States.ENGAGE:
		return
	var arrived_to_next_point = move_to(target_point_world)
	if arrived_to_next_point:
		path.remove(0)
		if len(path) == 0:
			set_state(States.PATROL)
			return
		target_point_world = path[0]
			
func move_to(world_position):
	var MASS = 10.0
	var ARRIVE_DISTANCE = 10.0

	var desired_velocity = (world_position - position).normalized() * SPEED
	var steering = desired_velocity - velocity
	velocity += steering / MASS
	position += velocity * get_process_delta_time()
	rotation = velocity.angle()
	return position.distance_to(world_position) < ARRIVE_DISTANCE


