extends Node2D

@onready var texto: Label = $texto
@onready var text_audio: AudioStreamPlayer = $TextAudio
@onready var musica: AudioStreamPlayer = $MusicaMenu

var reproduciendo := false


func _ready() -> void:
	$AnimationPlayer.play("Movimiento")
	$MusicaMenu.stream.loop = true
	$MusicaMenu.volume_db = 0.0
	$MusicaMenu.play()


func _physics_process(delta: float):

	if not reproduciendo:
		reproduciendo = true
		
		await mostrar_texto("Este es el final")
		await esperar_y_desaparecer()

		await mostrar_texto("Pero estamos indecisos... tu balanza esta exactamente en el medio...")
		await esperar_y_desaparecer()

		await mostrar_texto("Te daremos un dia mas en la tierra... para que hagas el bien")
		await esperar_y_desaparecer(4.0)

		await mostrar_texto("Solo 24 horas. NIVELA tu vida")
		await esperar_y_desaparecer(2.0)

		await mostrar_texto("No nos defraudes")
		await esperar_y_desaparecer()

		await mostrar_texto("No te defraudes")
		await esperar_y_desaparecer()

		await mostrar_texto("Vive de nuevo")
		await esperar_y_desaparecer(1.5)

		await mostrar_texto("24 horas")
		await esperar_y_desaparecer()

		await mostrar_texto("No te quedes en el Limbo")

		await get_tree().create_timer(1.0).timeout

		await fadeout_final()

		get_tree().change_scene_to_file("res://maps/mundo.tscn")
		
	if Input.is_action_just_pressed("Jump"):
		get_tree().change_scene_to_file("res://maps/mundo.tscn")

func mostrar_texto(nuevo_texto: String):
	texto.text = ""
	texto.modulate.a = 1.0
	await escribir_texto(nuevo_texto)


func escribir_texto(nuevo_texto: String):
	texto.text = ""
	texto.modulate.a = 1.0

	for caracter in nuevo_texto:
		
		text_audio.play()
		texto.text += caracter
		await get_tree().create_timer(0.02).timeout


func esperar_y_desaparecer(espera: float = 3.0):
	await get_tree().create_timer(espera).timeout

	var tween = create_tween()
	tween.tween_property(texto, "modulate:a", 0.0, 1.0)
	await tween.finished

	texto.text = ""


func esperar_fin_de_musica():
	if not musica.playing:
		return

	while musica.playing:
		await get_tree().process_frame


func fadeout_final():
	var tween = create_tween()
	tween.tween_property(texto, "modulate:a", 0.0, 1.0)
	await tween.finished
