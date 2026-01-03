extends Resource
class_name SkillData


@export var name: String
@export var sp_cost: int = 0
@export var modifier: int = 10


func execute(user: CharacterBase, target: CharacterBase):
	target.take_damage(modifier*user.data.attack)
