extends RichTextLabel

func _ready():
	percent_visible = 0

func _physics_process(delta):
	if percent_visible < 1:
		percent_visible += 0.01
