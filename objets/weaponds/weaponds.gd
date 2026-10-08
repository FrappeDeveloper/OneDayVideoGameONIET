extends Area2D


var can_take=false
@export var player=null

@export var damage=0
@export var delay=0
@export_enum("Mele","Gun","Item") var kind:String
@export var bullets=0


func _ready() -> void:
	player=get_tree().get_first_node_in_group("Player")

func _input(event: InputEvent) -> void:
		
	if Input.is_action_just_pressed("Interactue") and can_take and GameManager.current_weapond==null:
		GameManager.current_weapond=duplicate()
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	can_take=true

func _on_area_exited(area: Area2D) -> void:
	can_take=false

func shooted():
	bullets-=1
	await player.get_tree().create_timer(delay).timeout
	player.is_waitting=false
	if bullets==0:
		GameManager.current_weapond=null
		queue_free()
func punch():
	player.is_waitting=true
	player.attack_box.set_collision_layer_value(7,true)
	player.attack_box.set_collision_mask_value(6,true)
	await get_tree().create_timer(delay).timeout
	player.attack_box.set_collision_layer_value(7,false)
	player.attack_box.set_collision_mask_value(6,false)
	player.is_waitting=false
