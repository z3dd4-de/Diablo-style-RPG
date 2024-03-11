extends Node

enum Outfit { CLOTHES, LEATHER, STEEL }
enum Weapon { NONE, DAGGER, GREATSTAFF, GREATSWORD, LONGSWORD, ROD, SHORTSWORD, STAFF, WAND }
enum Head { MALE1, MALE2, MALE3, FEMALE }
enum Shield { NONE, BUCKLER, SHIELD }
enum Bow { NONE, SLINGSHOT, SHORTBOW, GREATBOW, LONGBOW }

signal SendMessage

var current_day = 1
var start_time
var end_time


func _ready() -> void:
	start_time = Time.get_unix_time_from_system()


func send_message(text: String) -> void:
	SendMessage.emit(text)


func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _notification(what) -> void:
	var config = ConfigFile.new()
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		print("Closing")
		config.save("user://settings.cfg")
		get_tree().quit() 
