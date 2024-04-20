extends Node

enum Outfit { CLOTHES, LEATHER, STEEL }
enum Weapon { NONE, DAGGER, GREATSTAFF, GREATSWORD, LONGSWORD, ROD, SHORTSWORD, STAFF, WAND }
enum Head { MALE1, MALE2, MALE3, FEMALE }
enum Shield { NONE, BUCKLER, SHIELD }
enum Bow { NONE, SLINGSHOT, SHORTBOW, GREATBOW, LONGBOW }

signal SendMessage
signal CloseMessage
signal TeleportActivated
signal LevelChanged
signal CloseGUI

var current_day: int = 1
var start_time
var end_time
var started: bool = false

var hero: Hero
var player_name: String
var current_experience: int = 0 
var current_level: int = 1
var current_skill_points: int = 20
var min_level_exp: int = 0
var max_level_exp: int = 0
var current_class: String = "Thief"
var current_head: int = 0
var basic_health: int = 100

var current_descr: String = "You already learned a little bit at the military academy where you studied:
	+2 Strength, +1 Agility, +1 Bow, +1 Melee, +20 Life Points"

@onready var questlog = preload("res://scenes/questlog.tscn")
@onready var keyboard_layout = preload("res://scenes/keyboard_layout.tscn")
@onready var pause_menu = preload("res://scenes/pause_menu.tscn")
@onready var day_night = preload("res://scenes/day_and_night.tscn")
@onready var char_menu = preload("res://scenes/character_ui.tscn")

var lock_shown: bool
var lock_id: int

var q_log
var q_log_visible: bool = false
var keys_layout
var keys_visible: bool = false
var p_menu
var p_menu_visible: bool = false
var c_menu
var c_menu_visible: bool = false

enum scene { WORLD1, EDITOR, INTRO, GRAVEYARD, GRAVEYARD_DUNGEON }
var current_scene

# Teleports
enum teleport_type { WORLD1, GRAVEYARD, GRAVEYARD_DUNGEON }

enum gate_state { OPENED, CLOSED }

# Tutorial messages
var fountain_tutorial_message_shown: bool = false
var tutorial_message_shown: bool = false

#

func _ready() -> void:
	start_time = Time.get_unix_time_from_system()
	
	q_log = questlog.instantiate()
	q_log.visible = q_log_visible
	get_parent().add_child.call_deferred(q_log)
	
	keys_layout = keyboard_layout.instantiate()
	keys_layout.visible = keys_visible
	get_parent().add_child.call_deferred(keys_layout)
	
	p_menu = pause_menu.instantiate()
	p_menu.visible = p_menu_visible
	get_parent().add_child.call_deferred(p_menu)
	
	c_menu = char_menu.instantiate()
	c_menu.visible = false
	get_parent().add_child.call_deferred(c_menu)
	
	lock_shown = false
	Globals.lock_id = -1


func calc_level(add_exp: int) -> void:
	current_experience += add_exp
	if current_level == 1:
		min_level_exp = 0
		max_level_exp = 10 * pow(2.0, 3.0)
	else:
		min_level_exp = 10 * pow(current_level, 3.0)
		max_level_exp = 10 * pow(current_level + 1, 3.0)
	if current_experience > max_level_exp:
		current_level += 1
		LevelChanged.emit()
		calc_level(0)


func send_message(text: String) -> void:
	SendMessage.emit(text)


func close_ui() -> void:
	CloseMessage.emit()
	CloseGUI.emit()
	

func activate_teleport(teleport: teleport_type) -> void:
	TeleportActivated.emit(teleport)


func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Globals.current_scene != Globals.scene.INTRO:
			p_menu_visible = !p_menu_visible
			if p_menu_visible:
				p_menu.get_node("CanvasLayer").visible = true
				get_tree().paused = true
			else:
				p_menu.get_node("CanvasLayer").visible = false
				get_tree().paused = false
		
	elif event.is_action_pressed("character"):
		c_menu_visible = !c_menu_visible
		if c_menu_visible:
			c_menu.get_node("CanvasLayer").visible = true
			get_tree().paused = true
			close_ui()
		else:
			c_menu.get_node("CanvasLayer").visible = false
			#q_log.visible = false
			get_tree().paused = false
			
	elif event.is_action_pressed("inventory"):
		pass  # Currently done directly by the hero
	 
	elif event.is_action_pressed("questlog"):
		q_log_visible = !q_log_visible
		if q_log_visible:
			print("Questlog is visible")
			q_log.get_node("CanvasLayer").visible = true
			#q_log.visible = true
			get_tree().paused = true
		else:
			print("Questlog is not visible")
			q_log.get_node("CanvasLayer").visible = false
			#q_log.visible = false
			get_tree().paused = false
	elif event.is_action_pressed("keys"):
		keys_visible = !keys_visible
		if keys_visible:
			keys_layout.get_node("CanvasLayer").visible = true
			get_tree().paused = true
		else:	# is not used, is changed in keyboard_layout.gd
			keys_layout.get_node("CanvasLayer").visible = false
			get_tree().paused = false


func create_keyboard_node() -> void:
	if keys_layout == null:		# is not used
		keys_layout = keyboard_layout.instantiate()
		keys_layout.visible = false
		get_parent().add_child(keys_layout)
	else:
		keys_layout.get_node("CanvasLayer").visible = false
		get_parent().add_child(keys_layout)


func create_pause_menu() -> void:
	if p_menu == null:
		p_menu = pause_menu.instantiate()
		p_menu.visible = false
		get_parent().add_child(p_menu)
	else: 
		p_menu.get_node("CanvasLayer").visible = false
		get_parent().add_child(p_menu)


func _notification(what) -> void:
	var config = ConfigFile.new()
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Closing")
		config.save("user://settings.cfg")
		get_tree().quit() 
