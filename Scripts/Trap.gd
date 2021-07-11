extends Node2D


var diffused = false
var diffusable = false
onready var player = $AnimationPlayer

func _process(delta):
	if diffusable == true and Input.is_action_just_pressed("ui_accept"):
		diffused = true
	
	if diffused == false:
		play_anim("active")
	else:
		play_anim("diffused")

func _on_kill_body_entered(body):
	if body.is_in_group("player") and !diffused:
		get_parent().get_parent().restart(get_parent().name.substr(get_parent().name.length() - 1, 1))


func _on_diffuse_body_entered(body):
	if body.is_in_group("player") and body.player == "1":
		diffusable = true

func on_diffuse_body_exited(body):
	if body.is_in_group("player"):
		diffusable = false

func play_anim(anim_name):
	if player.is_playing() and player.current_animation == anim_name:
		return
	player.play(anim_name)
