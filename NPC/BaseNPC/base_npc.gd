extends CharacterBody2D

@export var waypoints: Array[Marker2D]
@export var speed: float


@onready var alert: Sprite2D = $Exclamation


var current_index = 0
var is_waiting = false
var is_player_close = false
var my_dialogue = preload("uid://cm2g775uklr30")
var is_dialogue_active = false

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _physics_process(delta: float) -> void:
	if is_player_close and Input.is_action_just_pressed("Interactue") and not is_dialogue_active:
		print('Inicio de un dialogo')
		DialogueManager.show_dialogue_balloon(my_dialogue)
	
	if is_waiting:
		return
	
	var min_distance = 5.0
	var target_position = waypoints[current_index].global_position
	var direction = target_position - global_position
	var distance = direction.length()
	
	direction = direction.normalized()
	velocity = direction * speed
	
	if distance < min_distance:
		current_index += 1
		velocity = Vector2.ZERO
		$Timer.start()
		is_waiting = true
		if current_index >= waypoints.size():
			current_index = 0
			
	move_and_slide()



func _on_timer_timeout() -> void:
	is_waiting = false


func _on_area_dialogo_area_entered(area: Area2D) -> void:
	alert.visible = true
	is_player_close = true


func _on_area_dialogo_area_exited(area: Area2D) -> void:
	alert.visible = false
	is_player_close = false

func _on_dialogue_started(dialogue):
	is_dialogue_active = true

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	is_dialogue_active = false
