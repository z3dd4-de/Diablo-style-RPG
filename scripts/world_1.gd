extends Node2D

#var hero: Hero
@onready var hero = $Hero


func _ready() -> void:
	Globals.create_keyboard_node()
	Globals.create_pause_menu()
	print("Player: " + Globals.player_name + " - " + Globals.current_class)
	load_level()


func load_level() -> void:
	Globals.current_scene = Globals.scene.WORLD1
	if Globals.tutorial_message_shown == false:
		Globals.send_message("You are weak and have no weapons. \nYou should try to find some water and food first!")
		Globals.tutorial_message_shown = true
	if Globals.started == false:
		Globals.start_time = Time.get_unix_time_from_system()
		Globals.started = true
	if Globals.hero == null:
		Globals.hero = $Hero
	else:
		hero = Globals.hero
