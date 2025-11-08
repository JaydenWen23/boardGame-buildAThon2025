extends Label

func _process(delta):
	text = 'Turnz: ' + str(GameManager.turnz)
