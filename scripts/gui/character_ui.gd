extends Control

var points: int
var strength: int
var agility: int
var spirit: int
var life: int
var melee: int
var bow: int
var block: int
var magic: int
var dagger: int
var mining: int
var crafting: int
var hunger: int
var thirst: int

var show_points: int
var saving_possible: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#DEBUG ONLY:
	Globals.current_experience = 450
	Globals.current_skill_points = 20
	points = Globals.current_skill_points
	Globals.calc_level(0)
	#show_points = points
	calc_points()
	_load_overview()
	$CanvasLayer.visible = false


func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		self.get_node("CanvasLayer").visible = false
		get_tree().paused = false
	elif  event.is_action_pressed("character"):
		#TODO: Saving
		self.get_node("CanvasLayer").visible = false
		get_tree().paused = false


func _load_overview() -> void:
	$CanvasLayer/TabContainer/Overview/VBoxContainer/GridContainer/LevelInt.text = str(Globals.current_level)
	$CanvasLayer/TabContainer/Overview/VBoxContainer/GridContainer/ExpInt.text = str(Globals.current_experience)
	$CanvasLayer/TabContainer/Overview/VBoxContainer/GridContainer/NextLevelHSlider.min_value = Globals.min_level_exp
	$CanvasLayer/TabContainer/Overview/VBoxContainer/GridContainer/NextLevelHSlider.max_value = Globals.max_level_exp
	$CanvasLayer/TabContainer/Overview/VBoxContainer/GridContainer/NextLevelHSlider.value = Globals.current_experience
	$CanvasLayer/TabContainer/Overview/VBoxContainer/GridContainer/CurrentClassLabel.text = Globals.current_class
	$CanvasLayer/TabContainer/Overview/VBoxContainer/GridContainer/SkillPointsInt.text = str(points)
	#PlayerName: TODO
	$CanvasLayer/TabContainer/Overview/VBoxContainer/GridContainer/LifePointsStr.text = "100/100" #TODO
	$CanvasLayer/TabContainer/Overview/VBoxContainer/GridContainer2/GeneralInfoRichtTextLabel.text = Globals.current_descr
	

func calc_points() -> void:
	show_points = points - strength - agility - spirit - life - melee - bow - block - magic - mining - crafting - hunger - thirst
	$CanvasLayer/TabContainer/Books/VBoxContainer/GridContainer4/SkillPointsLabel.text = str(show_points)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer4/SkillPointsLabel.text = str(show_points)
	$CanvasLayer/TabContainer/Knowledge/VBoxContainer/GridContainer4/SkillPointsLabel.text = str(show_points)
	show_error()


func show_error() -> void:
	var str1 = "Press \"C\" so save changes, \"ESC\" to quit without changes."
	var str2 = "Error: Remaining Skill Points can\'t be < 0. Saving not possible!"
	if show_points < 0:
		$CanvasLayer/TabContainer/Character/VBoxContainer/SaveDescrLabel.text = str2
		$CanvasLayer/TabContainer/Knowledge/VBoxContainer/SaveDescrLabel.text = str2
		saving_possible = false
	else:
		$CanvasLayer/TabContainer/Character/VBoxContainer/SaveDescrLabel.text = str1
		$CanvasLayer/TabContainer/Knowledge/VBoxContainer/SaveDescrLabel.text = str1
		saving_possible = true


func _on_strength_h_slider_value_changed(value) -> void:
	strength = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer/StrengthPointsLabel.text = str(10 + strength) + "/" + str(10 + strength) 
	calc_points()


func _on_agility_h_slider_value_changed(value) -> void:
	agility = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer/AgilityPointsLabel.text = str(10 + agility) + "/" + str(10 + agility)  
	calc_points()

func _on_spirit_h_slider_value_changed(value) -> void:
	spirit = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer/SpiritPointsLabel.text = str(10 + spirit) + "/" + str(10 + spirit)
	calc_points()


func _on_life_points_h_slider_value_changed(value) -> void:
	life = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer/LifePointsPointsLabel.text = str(100 + life) + "/" + str(100 + life)
	calc_points()


func _on_melee_h_slider_value_changed(value) -> void:
	melee = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer2/MeleePointsLabel.text = "+" + str(10 + melee)
	calc_points()


func _on_bow_h_slider_value_changed(value) -> void:
	bow = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer2/BowPointsLabel.text = str(10 + bow) + "%"
	calc_points()


func _on_block_h_slider_value_changed(value) -> void:
	block = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer2/BlockPointsLabel.text = str(10 + block) + "%"
	calc_points()


func _on_magic_h_slider_value_changed(value) -> void:
	magic = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer2/MagicPointsLabel.text = str(magic)
	calc_points()


func _on_mining_h_slider_value_changed(value) -> void:
	mining = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer3/MiningPointsLabel.text = str(mining) + "%"
	calc_points()


func _on_crafting_h_slider_value_changed(value) -> void:
	crafting = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer3/CraftingPointsLabel.text = str(crafting) + "%"
	#$CanvasLayer/TabContainer/Knowledge/VBoxContainer/GridContainer/CraftingPointsLabel.text = str(crafting) + "%"
	calc_points()


func _on_resist_hunger_h_slider_value_changed(value) -> void:
	hunger = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer3/ResistHungerPointsLabel.text = str(hunger) + "%"
	calc_points()


func _on_resist_thirst_h_slider_value_changed(value) -> void:
	thirst = int(value)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer3/ResistThirstPointsLabel.text = str(thirst) + "%"
	calc_points()


func _on_dagger_kill_h_slider_value_changed(value):
	dagger = int(points)
	$CanvasLayer/TabContainer/Character/VBoxContainer/GridContainer2/DaggerKillPointsLabel.text = str(dagger)
	calc_points()
