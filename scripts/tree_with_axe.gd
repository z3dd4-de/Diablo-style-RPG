extends StaticBody2D

enum state { WITH_AXE, WITHOUT_AXE }
var current_state = state.WITH_AXE

var player: CharacterBody2D = null


func _ready() -> void:
	play_animation()
	player = null


func play_animation() -> void:
	if current_state == state.WITH_AXE:
		$AnimatedSprite2D.play("with_axe")
	else:
		$AnimatedSprite2D.play("without_axe")


func remove_axe() -> void:
	if player:
		Globals.send_message("You now have an axe and can get wood from trees.")
		current_state = state.WITHOUT_AXE
		play_animation()
		player.has_axe = true
	


func _input(event) -> void:
	if event.is_action_pressed("pick_item") and player != null and current_state == state.WITH_AXE and player.has_axe == false:
		remove_axe()
	else:
		return


func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player = body


func _on_area_2d_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player = null
