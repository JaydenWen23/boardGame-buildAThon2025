extends Node2D

var is_dragging = false
var offset: Vector2

func _ready():
	# Make sure area can detect input
	$Area2D.input_ray_pickable = true

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Check if click is inside our Area2D
			var mouse_pos = get_global_mouse_position()
			var space_state = get_world_2d().direct_space_state
			var query = PhysicsPointQueryParameters2D.create(mouse_pos)
			query.collision_mask = $Area2D.collision_mask
			var result = space_state.intersect_point(query)
			
			for collision in result:
				if collision.collider == $Area2D:
					print("Clicked on: ", name)
					offset = mouse_pos - global_position
					is_dragging = true
					Global.is_dragging = true
					break
		else:
			if is_dragging:
				is_dragging = false
				Global.is_dragging = false

func _process(delta):
	if is_dragging:
		global_position = get_global_mouse_position() - offset
