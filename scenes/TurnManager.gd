extends Node
class_name TurnManager


var turn_queue: Array[CharacterBase] = []
var current_index := 0


func _ready() -> void:
	BattleController.register_turn_manager(self)


func setup(characters: Array[CharacterBase]):
	turn_queue = characters
	turn_queue.sort_custom(func(a, b):
		return a.data.speed > b.data.speed
	)
	current_index = 0
	start_next_turn()


func start_next_turn():
	print("---- NEXT TURN ----")
	if turn_queue.is_empty():
		return


	if current_index >= turn_queue.size():
		current_index = 0


	var character = turn_queue[current_index]


	if not character.is_alive:
		turn_queue.remove_at(current_index)
		start_next_turn()
		return


	character.turn_ended.connect(_on_turn_ended)
	character.start_turn()


func _on_turn_ended(character):
	character.turn_ended.disconnect(_on_turn_ended)
	current_index += 1
	start_next_turn()
