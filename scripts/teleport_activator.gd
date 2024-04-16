extends StaticBody2D
class_name TeleportActivator

enum state { ACTIVE, INACTIVE }

var current_state: state = state.INACTIVE
@export var my_name: Globals.teleport_type

var player: CharacterBody2D

signal Activated


func _ready() -> void:
	play_animation()
	player = null


func set_active() -> void:
	if current_state == state.INACTIVE:
		current_state = state.ACTIVE
		play_animation()
		Globals.TeleportActivated.emit(my_name)


func play_animation() -> void:
	if current_state == state.INACTIVE:
		$AnimatedSprite2D.play("inactive")
	else:
		$AnimatedSprite2D.play("active")


func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player = body


func _on_area_2d_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player = null


func _input(event) -> void:
	if event.is_action_pressed("pick_item") and player != null:
		if current_state == state.INACTIVE:
			_place_rune()
		else:
			Globals.TeleportActivated.emit(my_name)


func _place_rune() -> void:
	if player:
		if my_name == Globals.teleport_type.WORLD1 and player.world_1_teleport_rune == true and current_state == state.INACTIVE:
			set_active()
			Globals.send_message("Something happened...")
		elif my_name == Globals.teleport_type.GRAVEYARD and player.graveyard_teleport_rune == true and current_state == state.INACTIVE:
			set_active()
			Globals.send_message("You activated another teleport...")
	else:
		return
