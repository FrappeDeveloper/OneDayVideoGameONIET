extends State


# Called when the node enters the scene tree for the first time.
func on_process(delta: float) -> void:
	control_node.velocity=Vector2.ZERO
	control_node.rotation=move_toward(control_node.rotation,PI/2,0.05)
	control_node.modulate-=Color(1.0, 1.0, 1.0, 0.0)*delta
	print( control_node.rotation, PI/2)
	if control_node.rotation>PI/2:
		control_node.queue_free()
