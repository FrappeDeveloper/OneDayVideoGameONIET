extends State


# Called when the node enters the scene tree for the first time.
func start():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_process(delta: float) -> void:
	if control_node.is_player_close and Input.is_action_just_pressed("Interactue") and not GameManager.is_dialogue_active:
		print('Inicio de un dialogo')
		DialogueManager.show_dialogue_balloon(control_node.my_dialogue)
		
	if control_node.is_waiting or GameManager.is_dialogue_active:
		return
	
	var min_distance = 5.0
	var target_position = control_node.waypoints[control_node.current_index].global_position
	var direction = target_position - control_node.global_position
	var distance = direction.length()
	
	direction = direction.normalized()
	control_node.velocity = direction * control_node.speed
	
	if distance < min_distance:
		control_node.current_index += 1
		control_node.velocity = Vector2.ZERO
		$"../../Timer".start()
		control_node.is_waiting = true
		if control_node.current_index >=control_node. waypoints.size():
			control_node.current_index = 0

func on_input(event: InputEvent) -> void:
	pass
