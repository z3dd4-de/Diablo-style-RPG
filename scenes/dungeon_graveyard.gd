extends Node2D


func _ready():
	Globals.create_keyboard_node()
	Globals.create_pause_menu()
	Globals.current_scene = Globals.scene.GRAVEYARD
	Globals.send_message("You entered the Dungeon beyond the Graveyard...")
