extends Node
class_name State_machine

@export var default_state:State

var control_node

var current_state:State

func _ready() -> void:
	current_state=default_state
	control_node=get_parent()
	start()
	
func start() -> void:
	current_state.control_node=control_node
	current_state.start()
	
func _process(delta: float) -> void:
	if GameManager.is_dialogue_active:
		return
	current_state.on_process(delta)
	
func change_to(state_name) -> void:
	var new_state=get_node_or_null(state_name)
	if not new_state==null:
		current_state=new_state
		start()

func _input(event: InputEvent) -> void:
	if GameManager.is_dialogue_active:
		return
	if control_node.name=="Player" :
		current_state.on_input(event)
