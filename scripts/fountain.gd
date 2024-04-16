extends StaticBody2D
class_name Fountain

var player: CharacterBody2D


func _ready() -> void:
	$AnimatedSprite2D.play("default")
	player = null


func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player = body
		if Globals.fountain_tutorial_message_shown == false:
			Globals.send_message("You can drink at fountains by pressing \"E\".")
			Globals.fountain_tutorial_message_shown = true


func _on_area_2d_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player = null


func _drink() -> void:
	if player:
		player.update_thirst(5)


func _input(event) -> void:
	if event.is_action_pressed("pick_item") and player != null:
		_drink()
