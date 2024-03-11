extends Label

@onready var fps_panel = $".."


func _process(_delta) -> void:
	var fps = Engine.get_frames_per_second()
	text = "FPS: " + str(fps)


func _input(_event) -> void:
	if Input.is_action_just_pressed("fps"):
		fps_panel.visible = !fps_panel.visible
