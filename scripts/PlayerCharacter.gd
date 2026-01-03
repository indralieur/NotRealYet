# res://characters/player_character.gd
extends CharacterBase
class_name PlayerCharacter


func start_turn():
	super.start_turn()
   


func on_skill_selected(skill, target):
	skill.execute(self, target)
	end_turn()
