extends Node

var is_dialogue_active = false
var has_meet_npc = false

## Puntuacion de buenas y malas acciones
var puntos_buenos = 0
var puntos_malos = 0

func increment_puntos_buenos(buenos_amount):
	puntos_buenos += buenos_amount

func increment_puntos_malos(malos_amount):
	puntos_malos += malos_amount
	
## Funciones q tengan dinero
var gold = 100

func decrease_gold(gold_amount):
	gold -= gold_amount
	if gold < 0:
		gold += gold_amount
		

func increment_gold(gold_amount):
	gold += gold_amount

## Funciones q tengan objetos

var current_weapond = null
var objeto_a_recibir: String

func entregar_objeto():
	current_weapond.queue_free()
	current_weapond = null

func recibir_objeto():
	current_weapond.queue_free()
	current_weapond = load("").instantiate()
	
