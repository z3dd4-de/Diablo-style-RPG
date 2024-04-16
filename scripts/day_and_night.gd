class_name DayNight extends Node2D

enum state { DAY, NIGHT }
var current_state = state.DAY
var change_state: bool = false

var length_of_day: int = 120
var length_of_night: int = 60


func _ready() -> void:
	$ColorRect.color.a = 0
	$Timer.wait_time = length_of_day
	$Timer.start()


func _process(_delta) -> void:
	if change_state == true:
		change_state = false
		change_daytime()


func _on_timer_timeout() -> void:
	change_state = true


func change_daytime() -> void:
	match current_state:
		state.DAY:
			$AnimationPlayer.play("day_to_night")
			$Timer.wait_time = length_of_night
			current_state = state.NIGHT
		state.NIGHT:
			$AnimationPlayer.play("night_to_day")
			$Timer.wait_time = length_of_day
			current_state = state.DAY
			Globals.current_day += 1
	$Timer.start()
