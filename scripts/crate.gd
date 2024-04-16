extends StaticBody2D
class_name Chest

enum state { CLOSED, OPEN }
var current_state = state.OPEN
var player: CharacterBody2D


func _ready() -> void:
	current_state = state.CLOSED
	play_anim()


func play_anim() -> void:
	if current_state == state.CLOSED:
		$AnimatedSprite2D.play("closed")
	else:
		$AnimatedSprite2D.play("open")


func switch_state() -> void:
	if current_state == state.OPEN:
		current_state = state.CLOSED
		if $Inventory != null:
			$Inventory.visible = false
	else:
		current_state = state.OPEN
		if $Inventory != null:
			$Inventory.visible = true
	#audio.play()
	$AudioStreamPlayer2D.play()
	play_anim()


func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player = body


func _on_area_2d_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player = null


func _input(event) -> void:
	if event.is_action_pressed("pick_item") and player != null:
		if current_state == state.OPEN:
			if $Inventory != null and $Inventory.visible:
				$Inventory.visible = false
			elif $Inventory != null and !$Inventory.visible:
				switch_state()
		elif current_state == state.CLOSED:
			switch_state()
