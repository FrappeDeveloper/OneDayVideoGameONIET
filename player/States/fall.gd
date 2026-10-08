extends State

var dir
# Called when the node enters the scene tree for the first time.
func start():
	control_node.sprite.play("jump")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_process(delta: float) -> void:
	dir=control_node.direction.x
	
	control_node.velocity.x=move_toward(control_node.velocity.x,control_node.speed*dir,control_node.acceleration)
	
	if control_node.is_on_floor():
		state_machine.change_to("Idle")
		


		
