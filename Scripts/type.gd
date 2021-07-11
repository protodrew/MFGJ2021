extends RichTextLabel

onready var player = $AudioStreamPlayer
var timer = 4
	
func _ready():
	percent_visible = 0

func _physics_process(delta):
	if percent_visible < 1:
		percent_visible += 0.005
		
		if timer < 1:
			player.play()
			timer = 20
		else:
			player.play()
			timer = 4
	if Input.is_action_just_pressed("ui_accept"):
		if self.name != "rest":
			get_parent().get_parent().change("1")
		
	timer -= 1
