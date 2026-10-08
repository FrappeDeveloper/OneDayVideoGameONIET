extends Node2D

@onready var texto: Label = $texto
@onready var text_audio: AudioStreamPlayer = $TextAudio
@onready var musica: AudioStreamPlayer = $MusicaMenu

@onready var pesa: Node2D = $Pesa

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

		await mostrar_texto("Y tu juicio a finalizado ...")
		await esperar_y_desaparecer()

		await mostrar_texto("Te dimos la oportunidad de un dia mas en la tierra... para que hagas el bien")
		await esperar_y_desaparecer(4.0)
		if GameManager.puntos_buenos<GameManager.puntos_malos:
			final_malo()
		elif GameManager.puntos_buenos/2<=GameManager.puntos_malos :
			final_neutro()
		else:
			final_bueno()
			
	if Input.is_action_just_pressed("Jump"):
		get_tree().change_scene_to_file("res://interface/menu/menu.tscn")

func final_malo():
	await mostrar_texto("Y en solo 24 horas has hecho demasiado mal")
	await esperar_y_desaparecer()

	await mostrar_texto("Poner en peligro personas")
	await esperar_y_desaparecer(2.0)

	await mostrar_texto("Engañarlas")
	await esperar_y_desaparecer(1.0)

	await mostrar_texto("Lastimarlas")
	await esperar_y_desaparecer(1.0)

	await mostrar_texto("Te dimos UNA oportunidad... y la aprobechaste para hacer el mal")
	await esperar_y_desaparecer()

	await mostrar_texto("AHORA SUFRE EL CASTIGO ETERNO")

	await get_tree().create_timer(1.0).timeout

	await fadeout_final()

	get_tree().change_scene_to_file("res://interface/menu/menu.tscn")

func final_neutro():
	await mostrar_texto("Y no lograste cambiar nada en 24 horas")
	await esperar_y_desaparecer()

	await mostrar_texto("Ni siquiera para mejorar tu destino")
	await esperar_y_desaparecer()

	await mostrar_texto("¿Sera que aceptas tu destino? ")
	await esperar_y_desaparecer(2.0)
	pesa.modulate-=Color(0.0, 0.0, 0.0, 0.267)
	await mostrar_texto("¿Te divierte ser una iregularidad del sistema?")
	await esperar_y_desaparecer(2.0)
	pesa.modulate-=Color(0.0, 0.0, 0.0, 0.506)
	await mostrar_texto("¿Creias que al no cambiar tu forma de vivir algo iba a cambiar magicamente?")
	await esperar_y_desaparecer()
	pesa.modulate-=Color(0.0, 0.0, 0.0, 0.792)
	await mostrar_texto("Pues esa respuesta sera una que lograras adquirir tras mediatar el resto de la enternidad en este sombrio lugar")
	pesa.modulate=Color(0.0, 0.0, 0.0, 0.0)
	await get_tree().create_timer(4).timeout
	await mostrar_texto("Ya que al no querer cambiar, tu destino tampoco lo hara")
	
	await get_tree().create_timer(4).timeout
	
	await fadeout_final()

	get_tree().change_scene_to_file("res://interface/menu/menu.tscn")

func final_bueno():
	await mostrar_texto("Y en 24 horas has hecho el bien que te faltaba")
	await esperar_y_desaparecer()

	await mostrar_texto("Ayudar a las personas")
	await esperar_y_desaparecer(1.0)

	await mostrar_texto("Respetandolas")
	await esperar_y_desaparecer(1.0)

	await mostrar_texto("No solo te hacias un bien a ti mismo, si no a ellas, al mundo")
	await esperar_y_desaparecer(1.0)

	await mostrar_texto("Aunque en tu vida antes de morir no fueras la de una mala persona, siempre fuiste mezquino con el bien que podrias hacer")
	await esperar_y_desaparecer()

	await mostrar_texto("Y siempre que pudiste hacer un poco mas de bien, decidiste que no, que no valia tu tu esfuerzo")
	await esperar_y_desaparecer()

	await mostrar_texto("Por eso, al fin alcanzaste el cielo, esta prueba era para que aprendieras una cosa, siempre se puede hacer un poco mas")
	await esperar_y_desaparecer()

	await mostrar_texto("Y no creas que tu aprendizaje fue demasiado tarde , tus acciones en la tierra lo transmitiran")
	await esperar_y_desaparecer()
	
	await mostrar_texto("Por eso, lo lograte")
	await get_tree().create_timer(1.0).timeout
	await mostrar_texto("Llegaste al cielo")
	await get_tree().create_timer(3.0).timeout
	await fadeout_final()

	get_tree().change_scene_to_file("res://interface/menu/menu.tscn")


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
