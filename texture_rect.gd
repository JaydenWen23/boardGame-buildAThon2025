extends TextureRect

func _get_drag_data(at_position):
	return texture
func _can_drop_data(at_position, data):
	return data is Texture2D
func _drop_data(at_position, data):
	print(data.resource_path)
	if data.resource_path == 'res://assets/factory1.png' and Varz.turn == 1: 
		texture = data
		Varz.turn = 2
	elif data.resource_path == 'res://assets/treetower.png' and Varz.turn == 2:
		texture = data 
		Varz.turn = 1
