extends KinematicBody2D

const MAX_SPEED = 200
const ACCELERATION = 80
const FRICTION = 40
var velocity = Vector2.ZERO # initializes an empty Vector2 that will store our X and Y velocity.
onready var sprite = $Sprite

# Called Every Tick that the Physics Updates
func _physics_process(delta):

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") # fluctuates between -1 and 1 with 0 being the resting place, stored in Vector2 to become xvelocity later
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")    # <- fluctuates between -1 and 1 with 0 being the resting place, stored in Vector2 to become yvelocity later
	input_vector = input_vector.normalized() # makes it so that moving diagonally isn't faster than moving in one of the 4 cardinal directions
	
	if Input.is_action_just_pressed("ui_changeL"):
		if sprite.frame == 0:
			sprite.frame = 2
		else:
			sprite.frame -= 1
			
	if Input.is_action_just_pressed("ui_changeR"):
		if sprite.frame == 2:
			sprite.frame = 0
		else:
			sprite.frame += 1
	
	if input_vector != Vector2.ZERO: #checks we are giving an input
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION) # sets velocity to input vectors as described above
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION) # moves velocity to zero incrementing by the FRICTION
		
	velocity = move_and_slide(velocity) # used for kinematic bodies, moves the KinematicBody2D and stops if a collision occurs multiplied by delta so framerate doesn't affect 

