extends CharacterBody2D

@onready var attack_box: Area2D = $sprite/attack_box
@onready var sprite = $sprite


const speed = 300.0
const jump_force = -400.0
const acceleration =50
const jump_acceleration = 60.0
const gravity = 1000.0

var direction=Vector2.ZERO

var timer:Timer

var bullet=preload("res://objets/weaponds/bullet.tscn").instantiate()


var is_waitting=false


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		
		velocity.y += gravity * delta

	direction.x = Input.get_axis("Left", "Right")
	
	if direction.x:
		sprite.scale.x=abs(sprite.scale.x)*direction.x
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Click") and GameManager.current_weapond!=null and not is_waitting and not GameManager.is_dialogue_active:
		if GameManager.current_weapond.kind=="Mele":
			sprite.play("mele")
			GameManager.current_weapond.punch()
		else:
			sprite.play("gun")
			var new_bullet= bullet.duplicate()
			new_bullet.rotation=new_bullet.get_angle_to(get_local_mouse_position())
			new_bullet.velocity=Vector2.RIGHT.rotated(new_bullet.rotation)*new_bullet.speed
			
			new_bullet.global_position=global_position
			is_waitting=true
			get_parent().add_child(new_bullet)
			
			GameManager.current_weapond.shooted()
	
	if Input.is_action_just_pressed("Drop") and GameManager.current_weapond!=null and not is_waitting and not GameManager.is_dialogue_active:
		var drop=GameManager.current_weapond.duplicate()
		drop.position=position
		get_parent().add_child(drop)
		GameManager.current_weapond.queue_free()
		GameManager.current_weapond=null


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Interface/animacion final/animacion_mas_alla_final.tscn")
