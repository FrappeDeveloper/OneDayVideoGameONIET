extends State


# Called when the node enters the scene tree for the first time.
func on_process(delta: float) -> void:

	control_node.velocity = Vector2.ZERO
	if not GameManager.is_dialogue_active:

		state_machine.change_to("Idle")
