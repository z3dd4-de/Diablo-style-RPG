class_name Lockpicking extends Control

signal Unlocked

var locks_dict = { 
	0: "LR",
	1: "LRRL"
}

var turn: int = -1


func _input(event) -> void:
	if event.is_action_pressed("ui_left") and Globals.lock_shown and $Timer.is_stopped() and Globals.lock_id != -1: 
		turn += 1
		$Panel/AnimatedSprite2D.flip_h = false
		$Panel/AnimatedSprite2D.play("turn")
		$AudioStreamPlayer.play()
		if locks_dict[Globals.lock_id][turn] == "L":
			$Timer.wait_time = 2
		else:
			$Panel/AnimatedSprite2D.play("broke")
			turn = -1
			$Timer.wait_time = 1
		$Timer.start()
	elif event.is_action_pressed("ui_right") and Globals.lock_shown and $Timer.is_stopped() and Globals.lock_id != -1:
		turn += 1
		$Panel/AnimatedSprite2D.flip_h = true
		$Panel/AnimatedSprite2D.play("turn")
		$AudioStreamPlayer.play()
		if locks_dict[Globals.lock_id][turn] == "R":
			$Timer.wait_time = 2
		else:
			$Panel/AnimatedSprite2D.play("broke")
			turn = -1
			$Timer.wait_time = 1
		$Timer.start()
	elif $Timer.is_stopped() and Globals.lock_shown:
		$Panel/AnimatedSprite2D.play("default")


func _test() -> void:
	if turn != -1 and turn == locks_dict[Globals.lock_id].length() - 1:
		Unlocked.emit()
		self.visible = false
		Globals.lock_id = -1
		turn = -1
		Globals.lock_shown = false


func _on_timer_timeout() -> void:
	_test()
	$Timer.stop()
	$Panel/AnimatedSprite2D.play("default")
