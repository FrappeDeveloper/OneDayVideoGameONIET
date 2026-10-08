extends CharacterBody2D

@export var live: float
@export var waypoints: Array[Marker2D]
@export var speed: float


@onready var alert: Sprite2D = $Exclamation
@onready var state_machine: State_machine = $State_machine


var current_index = 0
var is_waiting = false
var is_player_close = false
var my_dialogue = preload("uid://6e1negb04ie1")

var player

func _ready() -> void:
	player=get_tree().get_first_node_in_group("Player")
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _physics_process(delta: float) -> void:

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
	GameManager.is_dialogue_active = true

func _on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.2).timeout
	GameManager.is_dialogue_active = false


func _on_hitbox_area_entered(area: Area2D) -> void:
	var enemy=area.get_parent()
	var enemy_weapond=GameManager.current_weapond
	
	velocity.x=sign(global_position.x-enemy.global_position.x)*300
	
	live-=enemy_weapond.damage
	
	if live<0:
		state_machine.change_to("Dead")
	else:
		state_machine.change_to("Knockback")


func _on_hitbox_body_entered(body: Node2D) -> void:
	state_machine.change_to("Dead")
