extends Node2D

enum state { ACTIVE, INACTIVE }
var current_state = state.INACTIVE


func change_state() -> void: 
	if current_state == state.ACTIVE:
		current_state = state.INACTIVE
	else:
		current_state = state.ACTIVE
	play_animation()


func play_animation() -> void:
	match current_state:
		state.ACTIVE:
			$AnimatedSprite2D.play("active")
		state.INACTIVE:
			$AnimatedSprite2D.play("inactive")


func _on_timer_timeout() -> void:
	current_state = state.INACTIVE
	play_animation()


func activate() -> void:
	current_state = state.ACTIVE
	play_animation()
	$Timer.start()
