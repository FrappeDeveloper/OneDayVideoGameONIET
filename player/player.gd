extends CharacterBody2D

@onready var attack_box: Area2D = $ColorRect/attack_box


const speed = 300.0
const jump_force = -400.0
const acceleration =50
const jump_acceleration = 60.0
const gravity = 1000.0

var direction=Vector2.ZERO

var current_weapond

var bullet

var is_waitting=false

func _ready() -> void:
	bullet=preload("res://objets/weaponds/bullet.tscn")

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		
		velocity.y += gravity * delta

	direction.x = Input.get_axis("Left", "Right")

	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click") and current_weapond!=null and not is_waitting:
		if current_weapond.kind=="Mele":
			is_waitting=true
			attack_box.set_collision_layer_value(7,true)
			attack_box.set_collision_mask_value(6,true)
			await get_tree().create_timer(current_weapond.delay).timeout
			attack_box.set_collision_layer_value(7,false)
			attack_box.set_collision_mask_value(6,false)
			is_waitting=false
		else:
			var new_bullet=bullet.instantiate()
			new_bullet.rotation=new_bullet.get_angle_to(get_local_mouse_position())
			new_bullet.velocity=Vector2.RIGHT.rotated(new_bullet.rotation)*new_bullet.speed
			new_bullet.global_position=global_position
			is_waitting=true
			get_parent().add_child(new_bullet)
			await get_tree().create_timer(current_weapond.delay).timeout
			is_waitting=false
func _on_attack_box_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
