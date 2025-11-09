extends Button



func _on_pressed():
	GameManager.tower_positions = []
	get_tree().reload_current_scene()
