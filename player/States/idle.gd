extends State


# Called when the node enters the scene tree for the first time.
func start():
	await get_tree().create_timer(0.1).timeout
	control_node.sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_process(delta: float) -> void:
	control_node.velocity.x=move_toward(control_node.velocity.x,0,control_node.acceleration)
	if control_node.direction.x!=0:
		state_machine.change_to("Move")

func on_input(event: InputEvent) -> void:
	if Input.is_action_pressed("Jump"):
		state_machine.change_to("Jump")
		
