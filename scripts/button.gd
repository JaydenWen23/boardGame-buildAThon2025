extends Button



func _on_pressed():
	GameManager.tower_positions.clear()
	get_tree().reload_current_scene()
