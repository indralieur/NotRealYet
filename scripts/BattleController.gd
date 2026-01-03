extends Node


var players: Array[PlayerCharacter] = []
var enemies: Array[EnemyCharacter] = []


var turn_manager: TurnManager


func register_turn_manager(tm: TurnManager):
	turn_manager = tm
	print("TurnManager registered:", tm)
   
func register_character(c: CharacterBase):
	if c is PlayerCharacter:
		players.append(c)
	elif c is EnemyCharacter:
		enemies.append(c)


	print("REGISTERED:", c)
   


func start_battle():
	var all_characters: Array[CharacterBase] = []
	all_characters.append_array(players)
	all_characters.append_array(enemies)


	turn_manager.setup(all_characters)
   
func on_character_turn_started(character: CharacterBase):
	if character is PlayerCharacter:
		BattleUI.show_player_turn(character)
	else:
		BattleUI.hide_player_ui()


func get_random_player():
	return players.pick_random()
