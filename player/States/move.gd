extends State

var dir
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_process(delta: float) -> void:
	control_node.sprite.play("move")
	dir=control_node.direction.x
	
	control_node.velocity.x=move_toward(control_node.velocity.x,control_node.speed*dir,control_node.acceleration)
	if dir==0:
		state_machine.change_to("Idle")
		
	if control_node.velocity.y!=0:
		state_machine.change_to("Fall")

func on_input(event: InputEvent) -> void:
	if Input.is_action_pressed("Jump"):
		state_machine.change_to("Jump")
		
