extends CharacterBody2D


const speed = 300.0
const jump_force = -400.0
const acceleration =50
const jump_acceleration = 60.0
const gravity = 1000.0

var direction=Vector2.ZERO
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		
		velocity.y += gravity * delta

	direction.x = Input.get_axis("Left", "Right")

	move_and_slide()
