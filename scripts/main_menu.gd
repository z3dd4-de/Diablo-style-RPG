extends Node2D

var version: String = "Version 0.1"


func _ready():
	$CanvasLayer/VersionLabel.text = get_version()


#TODO
func get_version() -> String:
	#var config = ConfigFile.new()
	#var err = config.load("user://settings.cfg")
	#print(err)
	#if err == OK:
	#	print("OK")
	#	#var version = config.get_value()
	#var preset = ConfigFile.new()
	#preset.load("res://export_presets.cfg")
	#print(preset.get_value("preset.0.options", "application/file_version"))
	return version


func _on_start_button_pressed():
	SceneManager.SwitchScene("World 1")


func _on_load_button_pressed():
	pass # Replace with function body.


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_credits_button_pressed():
	SceneManager.SwitchScene("Credits")


func _on_exit_button_pressed():
	SceneManager.QuitGame()
