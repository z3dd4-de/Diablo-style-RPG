extends Control

@onready var character_designer = $Panel/GridContainer/ColorRect/CharacterDesigner


# Called when the node enters the scene tree for the first time.
func _ready():
	character_designer._animation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_class_option_button_item_selected(index):
	print("Item selected: ", index)
	match index:
		0:
			print("Fighter")
			character_designer.my_class = character_designer.hero_class.FIGHTER
			character_designer.switch_class("Fighter")
		1:
			print("Archer")
			character_designer.my_class = character_designer.hero_class.FIGHTER
			character_designer.switch_class("Archer")
		2:
			print("Mage")
			character_designer.my_class = character_designer.hero_class.FIGHTER
			character_designer.switch_class("Mage")
		3:
			print("Thief")
			character_designer.my_class = character_designer.hero_class.FIGHTER
			character_designer.switch_class("Thief")
	character_designer._animation()
