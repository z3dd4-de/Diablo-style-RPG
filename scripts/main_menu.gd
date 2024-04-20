extends Node2D

var version: String = "Version 0.1"

@onready var _master = AudioServer.get_bus_index("Master")
@onready var _music = AudioServer.get_bus_index("Music")
@onready var _sfx = AudioServer.get_bus_index("SFX")


func _ready() -> void:
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


func _on_start_button_pressed() -> void:
	SceneManager.SwitchScene("CharacterBuilder")


func _on_load_button_pressed() -> void:
	pass # Replace with function body.


func _on_options_button_pressed() -> void:
	$CanvasLayer/MainVBoxContainer.visible = false
	$CanvasLayer/OptionsVBoxContainer.visible = true


func _on_credits_button_pressed() -> void:
	SceneManager.SwitchScene("Credits")


func _on_exit_button_pressed() -> void:
	SceneManager.QuitGame()


func _on_options_back_button_pressed() -> void:
	$CanvasLayer/MainVBoxContainer.visible = true
	$CanvasLayer/OptionsVBoxContainer.visible = false


func _on_audio_button_pressed() -> void:
	$CanvasLayer/OptionsVBoxContainer.visible = false
	$CanvasLayer/AudioVBoxContainer.visible = true


func _on_audio_back_button_pressed() -> void:
	$CanvasLayer/OptionsVBoxContainer.visible = true
	$CanvasLayer/AudioVBoxContainer.visible = false


func _on_master_h_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(_master, linear_to_db(value))


func _on_music_h_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(_music, linear_to_db(value))


func _on_effects_h_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(_sfx, linear_to_db(value))
	$AudioStreamPlayer2D_Sfx.play()
