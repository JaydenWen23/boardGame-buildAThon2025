extends Label

func _init():
	pass
	text = str(GameManager.turn)
func _process(delta):
	text = 'TURN' + str(GameManager.turn)
