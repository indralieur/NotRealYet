# res://resources/character_data.gd
extends Resource
class_name CharacterData


@export var name: String
@export var max_hp: int = 100
@export var attack: int = 10
@export var defense: int = 5
@export var speed: int = 10


@export var skills: Array[SkillData] = []
