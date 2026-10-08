extends Area2D


var can_take=false
var player

@export var damage=0
@export var delay=0
@export_enum("Mele","Gun") var kind:String
@export var bullets=0

func _ready() -> void:
	player=get_tree().get_first_node_in_group("Player")


func _input(event: InputEvent) -> void:
	if bullets==0:
		player.current_weapond=null
		
	if Input.is_action_just_pressed("Interactue") and can_take and player.current_weapond==null:
		player.current_weapond=duplicate()
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	can_take=true


func _on_area_exited(area: Area2D) -> void:
	can_take=false
