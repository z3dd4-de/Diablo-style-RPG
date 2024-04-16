extends StaticBody2D

@export var my_name: Globals.teleport_type

var has_hero: bool = false
var player: CharacterBody2D


func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player = body


func _on_area_2d_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player = null


func _pick_up() -> void:
	if player:
		if my_name == Globals.teleport_type.WORLD1 and player.world_1_teleport_rune == false:
			player.world_1_teleport_rune = true
			self.visible = false
			Globals.send_message("You found a weird stone...")
		elif my_name == Globals.teleport_type.GRAVEYARD and player.graveyard_teleport_rune == false:
			player.graveyard_teleport_rune = true
			self.visible = false
			Globals.send_message("You found another teleport rune...")
	else:
		return


func _input(event) -> void:
	if event.is_action_pressed("pick_item") and player != null:
		_pick_up()
