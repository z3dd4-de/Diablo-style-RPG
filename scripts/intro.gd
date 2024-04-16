extends Node2D

func _ready() -> void:
	Globals.current_scene = Globals.scene.INTRO


func _on_close_button_pressed() -> void:
	load_first_map()


func load_first_map() -> void:
	SceneManager.SwitchScene("World 1")


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		load_first_map()
