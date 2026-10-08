extends CharacterBody2D


const speed = 300.0


func _physics_process(delta: float) -> void:
	move_and_slide()
