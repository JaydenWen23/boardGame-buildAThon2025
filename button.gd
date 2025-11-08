extends Button

const MyScene = preload("res://obj.tscn")

func _on_pressed():
	var new_instance = MyScene.instantiate()
	new_instance.position
	add_child(new_instance)
