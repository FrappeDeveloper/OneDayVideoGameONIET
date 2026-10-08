extends CharacterBody2D


const speed = 600.0


func _physics_process(delta: float) -> void:
	move_and_slide()
