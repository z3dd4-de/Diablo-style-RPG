extends Control


func _on_continue_button_pressed() -> void:
	self.get_node("CanvasLayer").visible = false
	get_tree().paused = false


func _on_save_button_pressed() -> void:
	pass # Replace with function body.


func _on_load_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	SceneManager.QuitGame()