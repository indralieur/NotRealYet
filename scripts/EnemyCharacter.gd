extends CharacterBase
class_name EnemyCharacter


var battle_controller: BattleController




func start_turn():
	super.start_turn()
	await get_tree().create_timer(0.5).timeout
	perform_ai()


func perform_ai():
	var target = battle_controller.get_random_player()
	var skill = data.skills.pick_random()
	skill.execute(self, target)
	end_turn()
