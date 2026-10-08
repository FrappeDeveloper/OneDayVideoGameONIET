extends State


# Called when the node enters the scene tree for the first time.
func start() -> void:
	control_node.modulate+=Color(0.643, 0.0, 0.0, 1.0)
	await get_tree().create_timer(0.5).timeout
	control_node.modulate-=Color(0.643, 0.0, 0.0, 1.0)
	
	state_machine.change_to("Scape")
