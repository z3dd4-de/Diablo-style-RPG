extends Control

@onready var character_designer = $Panel/GridContainer/ColorRect/CharacterDesigner

var player_name: String


func _ready() -> void:
	_change_class(3)
	$OKButton.disabled = true


func _on_class_option_button_item_selected(index) -> void:
	_change_class(index)


func _change_class(index: int) -> void:
	match index:
		0:
			character_designer.my_class = character_designer.hero_class.FIGHTER
			character_designer.switch_class("Fighter")
			$Panel/HistoryLongText.text = "You have been assigned to be a soldier in the king\'s army. As your training just started, you just have learned how to fight with the sword."
			$Panel/GridContainer/ClassBonusRichTextLabel.text = "+2 Strength, +1 Agility, +2 Melee, +20 Life Points"
		1:
			character_designer.my_class = character_designer.hero_class.ARCHER
			character_designer.switch_class("Archer")
			$Panel/HistoryLongText.text = "The king decided that due to war preparations a lot more good archers would be needed to protect cities and castles from the anticipated ork attacks. You just started your training and know how to use the bow, but it would be a long way to master it."
			$Panel/GridContainer/ClassBonusRichTextLabel.text = "+3 Agility, +2 Bow, +20 Life Points"
		2:
			character_designer.my_class = character_designer.hero_class.MAGE
			character_designer.switch_class("Mage")
			$Panel/HistoryLongText.text = "The king needs more mages to prepare for fight, thus the monks of your monastery have decided to send you to the mainland for becoming a fighting mage. As your training has just begun, you only know how to use simple fire ball spells. A lot more training would be needed to become a good fighter."
			$Panel/GridContainer/ClassBonusRichTextLabel.text = "+2 Spirit, +3 Magic, +1 Resistance, -10 Life Points"
		3:
			character_designer.my_class = character_designer.hero_class.THIEF
			character_designer.switch_class("Thief")
			$Panel/HistoryLongText.text = "The guards of the capital have caught you while commiting theft. They put you on the ship to be finally convicted. Because of your past you already know lockpicking. "
			$Panel/GridContainer/ClassBonusRichTextLabel.text = "Dagger-1-hit-kill, +2 Agility, +2 Spirit, Lockpicking, +10 Life Points"
	_test_ok_button()


func _on_head_option_button_item_selected(index) -> void:
	character_designer.change_head(index)


func _on_name_line_edit_text_changed(new_text):
	_test_ok_button()


func _test_ok_button() -> void:
	if $Panel/GridContainer/NameLineEdit.text == "":
		$OKButton.disabled = true
	elif $Panel/GridContainer/NameLineEdit.text != "" and $Panel/GridContainer/ClassOptionButton.get_selected() != -1:
		$OKButton.disabled = false


func _on_ok_button_pressed():
	#TODO: create hero
	Globals.player_name = $Panel/GridContainer/NameLineEdit.text
	Globals.current_class = $Panel/GridContainer/ClassOptionButton.text
	Globals.current_descr = $Panel/HistoryLongText.text
	Globals.basic_health = 100
	match Globals.current_class:
		"Fighter":
			Globals.basic_health += 20 
		"Archer":
			Globals.basic_health += 20 
		"Mage":
			Globals.basic_health -= 10 
		"Thief":
			Globals.basic_health += 10 
	self.visible = false
	SceneManager.SwitchScene("Intro")
