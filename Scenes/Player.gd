extends KinematicBody2D


var MAX_SPEED = 100
var ACCELERATION = 400
var FRICTION = 100
var velocity = Vector2.ZERO # initializes an empty Vector2 that will store our X and Y velocity.
var last_input = Vector2.ZERO

# Called Every Tick that the Physics Updates
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") # fluctuates between -1 and 1 with 0 being the resting place, stored in Vector2 to become velocity later
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")    # <- fluctuates between -1 and 1 with 0 being the resting place, stored in Vector2 to become velocity later
	input_vector = input_vector.normalized()
	
	
	if input_vector != Vector2.ZERO: #checks we are giving an input
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION) # sets velocity to input vectors as described above
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION) # moves velocity to zero incrementing by the FRICTION
		
	velocity = move_and_slide(velocity) # used for kinematic bodies, moves the KinematicBody2D and stops if a collision occurs multiplied by delta so framerate doesn't affect 
