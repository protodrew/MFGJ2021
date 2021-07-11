extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var col = $Area2D


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		body.freeze()
		print("piss")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_parent().isglyph = false
	queue_free()
