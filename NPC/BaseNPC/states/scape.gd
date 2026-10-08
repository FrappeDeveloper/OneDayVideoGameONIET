extends State


# Called when the node enters the scene tree for the first time.
func on_process(delta: float) -> void:
	control_node.velocity.x= sign(control_node.global_position.x-control_node.player.global_position.x)*control_node.speed*2
