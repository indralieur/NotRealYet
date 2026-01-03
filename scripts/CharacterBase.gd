extends Node2D
class_name CharacterBase

@export var data: CharacterData

var current_hp: int
var hp_percent: int
var is_alive: bool = true

signal turn_started(character)
signal turn_ended(character)
signal died(character)

func _ready():
	current_hp = data.max_hp
	hp_percent = ((current_hp / data.max_hp) * 100)
	print("Initial HP : {n} ({hp})".format({'n': name, 'hp': current_hp }))
	BattleController.register_character(self)

func start_turn():
	print("START TURN:", self)
	BattleController.on_character_turn_started(self)
	emit_signal("turn_started", self)

func end_turn():
	emit_signal("turn_ended", self)

func take_damage(amount: int):
	var dmg = max(amount - data.defense, 1)
	current_hp -= dmg

	if current_hp <= 0:
		die()

func heal(amount: int):
	current_hp = min(current_hp + amount, data.max_hp)

func die():
	is_alive = false
	emit_signal("died", self)
	queue_free()
