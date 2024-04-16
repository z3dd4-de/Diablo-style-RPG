extends Control


func _input(event) -> void:
	if event.is_action_pressed("questlog"):
		Globals.q_log.visible = false
		self.get_node("CanvasLayer").visible = false
		get_tree().paused = false
