extends KinematicBody2D

const MAX_SPEED = 150
const ACCELERATION = 80
const FRICTION = 40
var velocity = Vector2.ZERO # initializes an empty Vector2 that will store our X and Y velocity.
onready var sprite = $Sprite
onready var anim = $animation
onready var sfx = $sfx
var facingright = 1
var player = "1"
var isglyph = false
var canchange = false
# Called Every Tick that the Physics Updates

func _ready():
	if get_parent().name == "Level 2":
		canchange = true

func _physics_process(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") # fluctuates between -1 and 1 with 0 being the resting place, stored in Vector2 to become xvelocity later
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")    # <- fluctuates between -1 and 1 with 0 being the resting place, stored in Vector2 to become yvelocity later
	input_vector = input_vector.normalized() # makes it so that moving diagonally isn't faster than moving in one of the 4 cardinal directions
	
	
	if Input.is_action_just_pressed("player_change") and canchange == true:
		sfx.stream = load("res://sfx/switch.wav")
		sfx.play()
		
		if player == "1":
			player = "2"
		else:
			player = "1"
		
		
	if Input.is_action_just_pressed("ui_accept") and player == "2" and !isglyph:
					var isglyph = true
					add_child(load("res://Scenes/glyph.tscn").instance())
			
	if input_vector != Vector2.ZERO: #checks we are giving an input
		
		if(input_vector.y < 0):
			play_anim("up" + player)
		elif(input_vector.y > 0):
			play_anim("down" + player)
		else:
			play_anim("run" + player)
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION) # sets velocity to input vectors as described above
	else:
	
		play_anim("idle"+player)
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION) # moves velocity to zero incrementing by the FRICTION
	
	if input_vector.x < 0 and facingright:
		flip()
	if input_vector.x > 0 and !facingright:
		flip()
	
		
	velocity = move_and_slide(velocity) # used for kinematic bodies, moves the KinematicBody2D and stops if a collision occurs multiplied by delta so framerate doesn't affect 
	
	


func play_anim(anim_name):
	if anim.is_playing() and anim.current_animation == anim_name:
		return
	anim.play(anim_name)

func flip():
	facingright = !facingright
	sprite.flip_h = !sprite.flip_h
