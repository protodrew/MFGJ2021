extends KinematicBody2D

var inview = false
var count = 20
var speed = 60
onready var shape = $CollisionShape2D
onready var bubbles = $Sprite2
onready var anim = $AnimationPlayer
onready var mv = $Sprite/enemyPlayer
onready var player = $AudioStreamPlayer
onready var cone = $Area2D
var frozen = false
var timer = 120
var facingright = false


func _ready():
	if ceil(rotation_degrees) == 90 or floor(rotation_degrees) == 270:
		bubbles.rotation_degrees = 90

func _process(delta):
	if !frozen:
		if inview == false:
			if count < 35:
				count += 1
			else:
				bubbles.visible = false
		else:
			count -= 1
			
		if count == 0:
			get_parent().get_parent().restart(get_parent().name.substr(get_parent().name.length() - 1, 1))
			
		
			
		if int(ceil(abs(rotation_degrees))) % 180 == 0 or int(floor(abs(rotation_degrees))) % 180 == 0:
			
			if speed < 0:
				play_anim_mv("up")
			else:
				play_anim_mv("down")
			
			move_and_slide(Vector2(0,speed))
		else:
			$Sprite.rotation_degrees = -90
			if speed < 0 and facingright:
				flip()
			if speed > 0 and !facingright:
				flip()
			play_anim_mv("horiz")
			move_and_slide(Vector2(-speed,0))
			
	else:
		timer -= 1
	if timer <= 0:
		frozen = false
	
func _on_Area2D_body_entered(body):
	if !frozen:
		
		if body.is_in_group("player"):
			player.pitch_scale = rand_range(.85,1.35)
			player.play()
			bubbles.visible = true
			play_anim("aha")
			inview = true
		
		if body.is_in_group("wall"):
			cone.rotation_degrees += 180
			speed *= -1
		
func _on_Area2D_body_exited(body):
	if !frozen:
		if body.is_in_group("player"):
			bubbles.visible = true
			play_anim("huh")
			inview = false
			count = 0
	else:
		inview = false
		count = 0

func freeze():
	timer = 120
	frozen = true

func play_anim(anim_name):
	if anim.is_playing() and anim.current_animation == anim_name:
		return
	anim.play(anim_name)

func play_anim_mv(anim_name):
	if mv.is_playing() and mv.current_animation == anim_name:
		return
	mv.play(anim_name)

func flip():
	facingright = !facingright
	$Sprite.scale.x *= -1
	$Sprite.rotation_degrees += 180


func _on_Area2D2_body_entered(body):
	if body.is_in_group("player") and !frozen:
		get_parent().get_parent().restart(get_parent().name.substr(get_parent().name.length() - 1, 1))
