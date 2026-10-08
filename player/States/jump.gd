extends State

var dir

# Called when the node enters the scene tree for the first time.
func start() -> void:
	control_node.velocity.y=control_node.jump_force

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_process(delta: float) -> void:
	dir=control_node.direction.x

	
	control_node.velocity.x=move_toward(control_node.velocity.x,control_node.speed*dir,control_node.acceleration)
		
	if control_node.velocity.y>0:
		
		state_machine.change_to("Fall")

func on_input(event: InputEvent) -> void:
	if not Input.is_action_pressed("Jump"):
		control_node.velocity.y=-100
		
