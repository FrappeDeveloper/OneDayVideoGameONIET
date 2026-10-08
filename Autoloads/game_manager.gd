extends Node

var is_dialogue_active = false
var gold = 100

func decrease_gold(gold_amount):
	gold -= gold_amount

var has_meet_npc = false

var current_weapond
