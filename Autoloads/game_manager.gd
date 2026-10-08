extends Node

var is_dialogue_active = false


var has_meet_npc = false

## Funciones q tengan dinero
var gold = 100

func decrease_gold(gold_amount):
	gold -= gold_amount
	if gold < 0:
		gold += gold_amount
		

func increment_gold(gold_amount):
	gold += gold_amount

## Funciones q tengan objetos

var current_weapond

func entregar_objeto():
	current_weapond.queue_free()
	current_weapond = null
	
