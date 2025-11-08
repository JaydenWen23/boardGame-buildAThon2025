extends Node2D

var draggable = false
var is_inside_dropable = false
var body_ref

func _on_area_2d_mouse_entered():
	if not Global.is_dragging:
		draggable = true
		scale =Vector2(1.05, 1.05)


func _on_area_2d_mouse_exited():
	pass # Replace with function body.


func _on_area_2d_mouse_shape_entered(shape_idx):
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	pass # Replace with function body.
