class_name Message extends CanvasLayer

@onready var messageText = $MarginContainer/MessageText

func _ready() -> void:
	Globals.SendMessage.connect(show_message)


func _on_timer_timeout() -> void:
	self.visible = false


func show_message(text: String) -> void:
	self.visible = true
	messageText.text = text
	$Timer.start()
