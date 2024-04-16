extends Node2D
class_name Graveyard

@export var hero: Hero


func _ready():
	Globals.create_keyboard_node()
	Globals.create_pause_menu()
	Globals.current_scene = Globals.scene.GRAVEYARD
	Globals.send_message("You entered the Graveyard...")
	#hero.thirst.current_water = Globals.hero.thirst.current_water
	#print("Graveyard: ", Globals.hero)
	#print("Graveyard: ", hero.thirst.current_water)
	#print(hero.position)


func _on_dungeon_entry_body_entered(body):
	SceneManager.SwitchScene("Dungeon_Graveyard")
