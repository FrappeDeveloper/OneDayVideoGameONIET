extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

var animando := false


func _ready() -> void:
	color_rect.visible = false
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$AnimationPlayer.play("Movimiento")
	$MusicaMenu.stream.loop = true
	$MusicaMenu.volume_db = 0.0
	$MusicaMenu.play()


func _on_iniciar_pressed() -> void:
	if animando:
		return
	animando = true
	color_rect.visible = true

	$AnimationPlayer.play("iniciar")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://game.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
