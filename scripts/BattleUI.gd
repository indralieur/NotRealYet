extends CanvasLayer


@onready var skill_panel := $SkillsPanel
@onready var target_cursor := $TargetCursor


@onready var active_player_name := $VitalsPanel/CharacterName
@onready var active_player_hp_label := $VitalsPanel/HealthBar/RealHealth
@onready var active_player_hp := $VitalsPanel/HealthBar




var current_context
var selected_skill


func show_player_turn(character: PlayerCharacter):
	show()


	# Set character name
	active_player_name.text = character.data.name


	# Update numeric HP overlay
	active_player_hp_label.text = str(character.current_hp, " / ", character.data.max_hp)


	# Update the progress bar as percentage
	var hp_percent = float(character.current_hp) / character.data.max_hp * 100
	active_player_hp.min_value = 0
	active_player_hp.max_value = 100
	active_player_hp.value = clamp(hp_percent, 0, 100)




func start_turn(context: Dictionary):
	current_context = context
	skill_panel.hide()


func show_skills():
	skill_panel.show_skills(current_context.skills)


	if not skill_panel.skill_selected.is_connected(_on_skill_selected):
		skill_panel.skill_selected.connect(_on_skill_selected)
	   
func _on_skill_selected(skill):
	selected_skill = skill
	skill_panel.hide()
	enter_target_selection()


func enter_target_selection():
	target_cursor.start(
		current_context.targets,
		func(target):
			confirm_skill(target)
	)




func confirm_skill(target):
	emit_signal("action_confirmed", {
		"type": "skill",
		"user": current_context.user,
		"skill": selected_skill,
		"targets": [target]
	})
	hide_all()
   
func hide_all():
	skill_panel.hide()
	target_cursor.hide()
