extends Control


func _input(event) -> void:
	if event.is_action_pressed("keys"):
		Globals.keys_layout.visible = false
		self.get_node("CanvasLayer").visible = false
		get_tree().paused = false
