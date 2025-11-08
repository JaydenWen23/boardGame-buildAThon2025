extends StaticBody2D

func _ready():
	modulate = Color(Color.AQUAMARINE, 0.7)
func _process(delta):
	if Global.is_dragging == true:
		visible = false
	elif Global.is_dragging == false:
		visible = true
